epoch_time = int(item.get('info', 0).get('info_timestamp', 0))
readable_time = time.ctime(epoch_time)
print(f"Device ID: {item.get('device_id', 'Not found')}\t\t{readable_time}")