#client creation with python

from kinto_http import Client

#TODO Use env. variables for auth
client = Client(server_url="https://kinto.dev.mozaws.net/v1",
                auth=('arpit', 'p4ssw0rd'))

records = client.get_records(bucket='default', collection='todos')
for i, record in enumerate(records):
    record['title'] = 'Todo {}'.format(i)

for record in records:
    client.update_record(record)
