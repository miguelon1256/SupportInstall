# -*- coding: utf-8 -*-

import sys
import time
import subprocess
import shutil

from helpers.cli import CLI
from helpers.config import Config
from helpers.template import Template

class Command:

    @classmethod
    def start(cls, frontend_only=False):
        config = Config()
        dict_ = config.get_dict()
 
        cls.stop(output=False, frontend_only=frontend_only)
        if frontend_only:
            CLI.colored_print('Launching frontend containers', CLI.COLOR_INFO)
        else:
            CLI.colored_print('Launching environment', CLI.COLOR_INFO)

            backend_command = [
                'docker-compose',
                '-f',
                'docker-compose.db.yml',
                '-p',
                config.get_prefix('backend'),
                'up',
                '-d'
            ]
            CLI.run_command(backend_command, dict_['support_api_path'])

        # Start the front-end containers
        # if config.frontend:

            # If this was previously a shared-database setup, migrate to
            # separate databases for KPI and KoBoCAT
            #Upgrading.migrate_single_to_two_databases(config)

            frontend_command = ['docker-compose',
                                '-f', 'docker-compose.frontend.yml',
                                '-f', 'docker-compose.frontend.override.yml',
                                '-p', config.get_prefix('frontend'),
                                'up', '-d']

            
            CLI.run_command(frontend_command, dict_['support_api_path'])


            # Start Dashboards container
            frontend_command = ['docker-compose',
                                '-f', 'docker-compose.shiny.yml',
                                '-p', config.get_prefix('dashboards'),
                                'up', '-d']
            CLI.run_command(frontend_command, dict_['support_api_path'])

    @classmethod
    def stop(cls, output=True, frontend_only=False):
        """
        Stop containers
        """
        config = Config()
        dict_ = config.get_dict()

        if config.frontend:

            print ("Shutting down docker containers...")

            # Shut down frontend containers
            frontend_command = ['docker-compose',
                                '-f', 'docker-compose.frontend.yml',
                                '-f', 'docker-compose.frontend.override.yml',
                                '-p', config.get_prefix('frontend'),
                                'down']
            CLI.run_command(frontend_command, dict_['support_api_path'])

            # Shutdown Dashboards container
            dashboards_command = ['docker-compose',
                                '-f', 'docker-compose.shiny.yml',
                                '-p', config.get_prefix('dashboards'),
                                'down']
            CLI.run_command(dashboards_command, dict_['support_api_path'])

        backend_command = [
            'docker-compose',
            '-f',
            'docker-compose.db.yml',
            '-p', config.get_prefix('backend'),
            'down'
        ]
        CLI.run_command(backend_command, dict_['support_api_path'])

        if output:
            CLI.colored_print('Support API has been stopped', CLI.COLOR_SUCCESS)
