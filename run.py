from dafsa_gen import prepare_tlds
import requests
import os

PSL_URL = "https://publicsuffix.org/list/public_suffix_list.dat"
PSL_LOCATION = "./psl_store/psl.dat"

DAFSA_OUTPUT = "./attachments/etld_data.inc"

exists = os.path.isfile(PSL_LOCATION)

#TODO Change condition later

if not exists:
    r = requests.get(PSL_URL, stream=True)
    with open(PSL_LOCATION, "wb") as psl:
        for chunk in r.iter_content(chunk_size=1024):
            if chunk:
                psl.write(chunk)
            else:
                print("Error!!!")

prepare_tlds.main(DAFSA_OUTPUT,PSL_LOCATION)
