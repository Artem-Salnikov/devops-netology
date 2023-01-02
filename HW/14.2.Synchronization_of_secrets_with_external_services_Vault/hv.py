import hvac
import os

env_token = os.environ['TOKEN_VAULT'].strip("\n")
client = hvac.Client(
    url='http://10.233.75.11:8200',
    token=env_token
)
client.is_authenticated()


secret = client.secrets.kv.v2.read_secret_version(
    path='hvac',
)
print ( "Secret = " + secret['data']['data']['netology'])