# Run this to sync files in this directory with remote server

rsync -rvPI /Users/ifeoluwa/Projects/SRE-Roadmap/some_static_site/ myAWS:/home/ec2-user/my-static-site && echo "Sync successful!" || echo "Sync failed"