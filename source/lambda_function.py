import requests
import json
import giphy_client
from giphy_client.rest import ApiException
import random
import os


# create an instance of the API class
api_instance = giphy_client.DefaultApi()
api_key = os.environ.get('API_KEY') # str | Giphy API Key.
q = 'cash-cat' # str | Search query term or prhase.
limit = 50 # int | The maximum number of records to return. (optional) (default to 25)
offset = 0 # int | An optional results offset. Defaults to 0. (optional) (default to 0)
rating = 'g' # str | Filters results by specified rating. (optional)
lang = 'en' # str | Specify default country for regional content; use a 2-letter ISO 639-1 country code. See list of supported languages <a href = \"../language-support\">here</a>. (optional)
fmt = 'json' # str | Used to indicate the expected response format. Default is Json. (optional) (default to json)



def lambda_handler(event, context):  # pragma: no cover

    url_gifs = []

    try:
        # Search Endpoint
        api_response = api_instance.gifs_search_get(api_key, q, limit=limit, offset=offset, rating=rating, lang=lang,fmt=fmt)

        for x in api_response.data:
            url_gifs.append(x.images.downsized.url)


    except ApiException as e:
        print("Exception when calling DefaultApi->gifs_search_get: %s\n" % e)

    webhook_url = os.environ.get('WEBHOOK_URL')

    data = {
        'text': 'Timesheets are due',
        'username': 'JenBot',
        'icon_emoji': ':robot_face:',
        'blocks': [
            {
                "type": "image",
                "title": {
                    "type": "plain_text",
                    "text": "Don't forget your timesheets!"
                },
                "block_id": "image4",
                "image_url": str(random.choice(url_gifs)),
                "alt_text": "An incredibly cute kitten."
            }
        ]
    }

    response = requests.post(
        webhook_url,
        data=json.dumps(data),
        headers={'Content-Type': 'application/json'}
    )

    print('Response: ' + str(response.text))
    print('Response code: ' + str(response.status_code))

