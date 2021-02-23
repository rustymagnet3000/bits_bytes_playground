#!/usr/bin/env python3
import re
import argparse


class HostNameCleaner:
    def __init__(self, orig_file):
        self.raw_file = orig_file
        self.hostnames = []
        self.clean_hostnames()

    def clean_hostnames(self):
        """
            Passed an Opened file
            Check if each line is a valid Hostname
            if line fails, return don't return that line
        """
        file_by_lines = self.raw_file.read().split("\n")
        for line in file_by_lines:
            if len(line) > 0 and line[0] != '#':
                host_sanitize_l1 = HostNameCleaner.remove_wildcard(line)
                host_sanitize_l2 = HostNameCleaner.is_valid_hostname(host_sanitize_l1)
                if host_sanitize_l2 is not None:
                    self.hostnames.append(host_sanitize_l2)

    @staticmethod
    def remove_wildcard(hostname):
        if hostname[0:2] == "*.":
            hostname = hostname[2:]
            hostname = HostNameCleaner.remove_wildcard(hostname)
        return hostname

    @staticmethod
    def is_valid_hostname(hostname):
        hostname_regex = re.compile("(?!-)[A-Z\d-]{5,63}(?<!-)$", re.IGNORECASE)
        num_periods = re.findall(r'\.', hostname)
        num_non_alpha = re.findall(r'\W', hostname)
        if len(hostname) > 255:
            return None
        if len(num_periods) == 0 or len(num_periods) > 4 or len(num_non_alpha) > len(num_periods):
            return None
        if len(re.findall(r'\s+', hostname)) > 0:    # remove hostnames with whitespace ( spaces / tabs )
            return None
        if all(hostname_regex.match(x) for x in hostname.split(".")) is not True:
            return hostname
        return None


if __name__ == '__main__':
    RE = re.compile(' +')
    parser = argparse.ArgumentParser(description="PyOpenSSL")
    parser.add_argument('--infile', type=argparse.FileType('r', encoding='UTF-8'), required=True)
    args = parser.parse_args()

    with args.infile as file:
        cleaner = HostNameCleaner(file)
        print(cleaner.hostnames)


########### input ###########
# no.commas,please
# stackoverflow.com
# httpbin.org
# weirddtstst
# GGorge. loves apples.
# *.google.com
# tab should  be  removed
# ....%%%%%....@@£££


########### Result ###########
# stackoverflow.com
# httpbin.org
# google.com
