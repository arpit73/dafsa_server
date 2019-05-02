# dafsa_server

A naive implementation of the server part of the psl-update project.
The dafsa generation code from firefox has been successfully ported to run on the server. 
The required C++ array is created and written to the file [etld_data.inc](attachments/etld_data.inc) (name is kept the same as used in firefox currently).

I have setup a kinto remote-server on an AWS EC2 instance at http://3.14.70.33:8888/v1 for testing, there is no useful code written to interact with kinto so far, I have only been looking at the API and different platforms to use. I have tested mostly with Python and Bash with a little NodeJs as well. The final code may be written in Python with the kinto-http.py module.

Run this with
```
python3 run.py
```

### Folder Structure
* dafsa_gen is module that processes and generates the dafsa.
* attachments folder contains the C++ byte array that is the dafsa to be uploaded.
* psl_store is where the raw psl is downloaded
* uploader contains some wip scripts that will upload the record to the server [Very Unfinished]


### Critical Bug

I think [prepare_tlds.py](dafsa_gen/prepare_tlds.py#53) has a major bug.
On running debugger I saw that domains names with accented character eg. `aéroport.ci` will cause the programme to fail.
The domain names can have accented characters in them but the ASCII standard doesn't support them and the rest of the programme deals with utf-8 as well.
```python
return encodings.idna.ToASCII(label)
```
So instead of returning a string the above will return an object that could be decode.
```python
return encodings.idna.ToASCII(label).decode("utf-8")
```
Decoding the object back to the utf-8 format makes it work.


Other changes are just there write the dafsa to a file.


### Setup

```bash
$ pip install -r requirements.txt
```

For Development setup the secrets.py file.
```bash
$ echo 'SERVER = "http://3.14.70.33:8888/v1" \nUSERNAME = "arpit73" \nPASSWORD = "s3cr3t"' > uploader/secrets.py
```
