def pages(start: int, end: int)->str:
    return f"""
                {{
                    "from": {start},
                    "size": {end}
                }}
            """