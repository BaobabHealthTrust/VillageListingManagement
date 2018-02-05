VILLAGE LISTING USER MANAGEMENT
------------------------------

DESCRIPTION
-----------

Application built in Ruby on Rails (RoR) 
to be used as a user management module to the Village Listing Application.

GETTING APPLICATION
-------------------

Get the application from github either by downloading it as a Zip file and extracting it 
or by cloning it into /var/www/

	By Clonning;

	https:
	
		https://github.com/BaobabHealthTrust/VillageListingUserManagement.git

	ssh:
	
		git@github.com:BaobabHealthTrust/VillageListingUserManagement.git

RUBY VERSION
------------

Ruby 2.2.2

	Verify that your Ruby Version Manager has ruby 2.2.2. activated for this application

Run

	bundle install

SYSTEM DEPENDENCIES
-------------------
	
1. Village Listing 

	Village Listing User Management works alongside Village Listing (development branch) for villages,
	districts, tas, and users. Make sure you have this application running alongside. 
	For more info, clone as a separate application from;

		https:
			
			https://github.com/BaobabHealthTrust/VillageListing.git

		ssh:

			git@github.com:BaobabHealthTrust/VillageListing.git

	and follow it's README. (Make sure you are in the 'development' branch)

2. CouchDB

	Make sure you have couchdb on the system as this application uses couchdb for Databases.

    To test for couchdb existence run the following command anywhere in terminal;
    
        curl http://127.0.0.1:5984/
        
    If output is as below then couchdb is installed and setup correctly;
        
        {"couchdb":"Welcome","uuid":"7f28e83989192dce8531276ee155f1be",
        "version":"1.6.0","vendor":{"name":"Ubuntu","version":"16.10"}}
        
CONFIGURATION
-------------

1. couchdb.yml
	
	In the config directory, configure the couchdb.yml by renaming or copying the couchdb.yml.example to couchdb.yml

	Set the database attributes as required for database connection.
	
	Major attributes that may require attention;
	
	    username, password

2. dde_connection.yml

	In the config directory, configure the dde_connection.yml by renaming or copying the dde_connection.yml.example to dde_connection.yml 

	Open the file with your favourite editor and set the following attributes;

		dde_server, dde_username, dde_password, site_code

	dde_server is the url with port on which DDE 2 Application is running on. 
	dde_username and dde_password is the username and password respectively to which couchdb is configured.
	The site code should be the code for the site at which the application is being developed for.

		eg. MTA for Mtema
		
3. secrets.yml
		
	In the config directory, configure the secrets.yml by renaming or copying the secrets.yml.example to secrets.yml

DATABASE CREATION & INITIALIZATION
----------------------------------

Run the following command to create and initialize systems application;

    rake vl:setup
    
RUN APPLICATION !!!!
-------------------
Yeay...!!! We all Good. :-)
