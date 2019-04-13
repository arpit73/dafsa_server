# dafsa_server

A naive implementation of the server part of the psl-update project.

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