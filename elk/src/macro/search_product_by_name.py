import json
def match_query(search):
    return   json.dumps(
                {
                    "query": {
                        "bool": {
                            "must": {
                                "match": {
                                    "name": {
                                        "query": search,
                                        "fuzziness": "AUTO"
                                    }
                                }
                            }
                        }
                    }
                }, indent = 4)