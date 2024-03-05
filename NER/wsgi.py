import predictor as myapp

# This is just a simple wrapper for gunicorn to find your app_local.
# If you want to change the algorithm file, simply change "predictor" above to the
# new file.

app = myapp.app