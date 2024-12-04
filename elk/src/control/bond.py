from os.path import dirname, abspath, join
from os import getenv
from dotenv import load_dotenv

# GET secrete data
def disclose():
    ENV_FIlE = join(dirname(abspath(__file__)), ".env")
    load_dotenv(ENV_FIlE)
    return {
        "ELASTIC_USER": getenv("ES_USER"),
        "ELASTIC_PASSWORD": getenv("ES_PASSWORD"),
        "ELASTIC_URL": getenv("ES_HOST_URL"),
        "ELASITC_CERT": getenv("ES_CA_PATH")
    }