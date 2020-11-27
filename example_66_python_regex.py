#!/usr/bin/env python3
import re
import argparse


def remove_wildcard(hostname):
    if hostname[0:2] == "*.":
        hostname = hostname[2:]
        hostname = remove_wildcard(hostname)
    return hostname


def is_valid_hostname(hostname, regex: re.Pattern):
    if len(hostname) > 255:
        return None

    x = re.findall(r'\.', hostname)
    if len(x) == 0 or len(x) > 4:
        return None

    if len(re.findall(r'\s+', hostname)) > 0:    # remove hostnames with whitespace ( spaces / tabs )
        return None

    if all(regex.match(x) for x in hostname.split(".")) is not True:
        return hostname

    return None


def return_clean_hostnames(infile):
    '''
        Passed an Opened file
        Check if each line can be passed into a web address.
        If it succeeds, add it to url List
        if line fails to be parsed by regex, throwaway and move to next line
        :return: [hostnames]
    '''
    hostnames = []
    hostname_regex = re.compile("(?!-)[A-Z\d-]{5,63}(?<!-)$", re.IGNORECASE)
    file_by_lines = infile.read().split("\n")
    for line in file_by_lines:
        if len(line) > 0 and line[0] != '#':
            host_sanitize_l1 = remove_wildcard(line)
            host_sanitize_l2 = is_valid_hostname(host_sanitize_l1, hostname_regex)
            if host_sanitize_l2 is not None:
                hostnames.append(host_sanitize_l2)
    for host in hostnames:
        print(host)


if __name__ == '__main__':
    RE = re.compile(' +')
    parser = argparse.ArgumentParser(description="PyOpenSSL")
    parser.add_argument('--infile', type=argparse.FileType('r', encoding='UTF-8'), required=True)
    args = parser.parse_args()

    with args.infile as file:
        return_clean_hostnames(file)


//input
stackoverflow.com
httpbin.org
weirddtstst
george. loves apples.
*.google.com
tab should  be  removed


// Result
stackoverflow.com
httpbin.org
google.com
