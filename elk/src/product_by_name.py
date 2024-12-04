import json

from control import es_cllient
from elk.src.macro import pagination
from elk.src.macro import search_product_by_name
client = es_cllient.adaptor()

query_body = pagination.pages(1,10)

query_body2 = search_product_by_name.match_query("Sony")
result = client.search(index="products", body = query_body)

pretty_json = json.dumps(result.body, indent=4)
print(pretty_json)

result2 = client.search(index="products", body=query_body2)
pretty_json2 = json.dumps(result2.body, indent=4)