import sys
import requests

filename = sys.argv[1]
webhook_url = "https://discord.com/api/webhooks/1372147285928181820/DwKmejZN8lJEWsXei9wsaMJca7ROv_6UEowrbovWnMXR2bLE2QYNfHf9BnuyxniMwr1z"

msg = {
    "content": f"🚨 Fichier suspect uploadé : `{filename}`\n📆 Analyse en cours."
}
requests.post(webhook_url, json=msg)
