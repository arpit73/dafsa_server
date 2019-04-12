from kinto_http import Client

client = Client(server_url="http://localhost:8888/v1",
                auth=('arpit', 'p4ssw0rd'))

records = client.get_records(bucket='default', collection='todos')
for i, record in enumerate(records):
    record['title'] = 'Todo {}'.format(i)

for record in records:
    client.update_record(record)
