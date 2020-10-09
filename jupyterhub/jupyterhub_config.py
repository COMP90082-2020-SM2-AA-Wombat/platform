import os

c = get_config()

c.JupyterHub.spawner_class = 'repo2dockerspawner.Repo2DockerSpawner'
c.Repo2DockerSpawner.build_image = 'jupyter/repo2docker:0.11.0'

# c.DockerSpawner.image = os.environ["DOCKER_JUPYTER_IMAGE"]
c.DockerSpawner.image = 'jupyter/scipy-notebook'
c.DockerSpawner.network_name = 'jupyterhub_network'
c.JupyterHub.hub_ip = '0.0.0.0' 
c.JupyterHub.hub_connect_ip = 'jupyterhub'
c.Authenticator.admin_users = {'admin'}
c.DockerSpawner.start_timeout = 600
c.JupyterHub.authenticator_class = 'nativeauthenticator.NativeAuthenticator'
# This will shut a user's server when they close their browser window
# c.JupyterHub.shutdown_on_logout = True

# c.JupyterHub.cookie_secret = bytes.fromhex('e60ea063651c08686d64d4b4fd762879765fbd52b36f130fba9776c4493c6ff2')

# Welcome Page
# c.Spawner.args = ['--NotebookApp.default_url=/hub/login']



# notebook_dir = os.environ.get('DOCKER_NOTEBOOK_DIR')
# c.DockerSpawner.notebook_dir = notebook_dir

# # Mount the real user's Docker volume on the host to the notebook user's
# # notebook directory in the container
# c.DockerSpawner.volumes = {
#           'jupyterhub-user-{username}': '/home/jovyan/work',
#           'jupyterhub-shared': '/home/jovyan/work/shared',
#           'jupyterhub-data': '/home/jovyan/work/data'
# }

# c.InteractiveShellApp.exec_lines = [
#     'pip3 install -r /etc/requirements.txt'
#     'import numpy as np\n'
#     'import numpy as np\n'
#     'import scipy as sp\n'
#     'import matplotlib as plt\n'
# ]

c.DockerSpawner.remove_containers = True
c.Spawner.default_url = '/lab'