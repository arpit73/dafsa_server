from kinto_http import Client
from kinto_http.patch_type import BasicPatch, MergePatch, JSONPatch

from secrets import SERVER, USERNAME, PASSWORD

credentials = (USERNAME, PASSWORD)

client = Client(server_url=SERVER,
                auth=credentials)

# To create a bucket.
client.create_bucket(id='payments')

buckets = client.get_buckets()

# To create or replace an existing bucket.
client.update_bucket(id='payments', data={'description': 'My payments data.'})

client.create_record(data={'status': 'done', 'title': 'Todo #1'},
                     collection='receipts', bucket='payments')
