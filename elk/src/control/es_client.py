from control import bond
from elasticsearch import Elasticsearch

ES_USER= bond.disclose()["ELASTIC_USER"]
ES_URL = bond.disclose()["ELASTIC_URL"]
ES_PASS= bond.disclose()["ELASTIC_PASSWORD"]
ES_CERT= bond.disclose()["ELASITC_CERT"]

def adaptor():
    try: 
        return Elasticsearch(
            ES_URL,
            ca_certs=ES_CERT,
            basic_auth=(ES_USER, ES_PASS)
        )
    except ConnectionRefusedError as e:
        print("Cannot connect to the elastic server", e)
