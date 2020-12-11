#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import platform
import sys

from helpers.config import Config
from helpers.singleton import Singleton
from helpers.cli import CLI
from helpers.template import Template
from helpers.command import Command

def run(force_setup=False):
    if not platform.system() in ['Linux', 'Darwin']:
        CLI.colored_print('Not compatible with this OS', CLI.COLOR_ERROR)
    else:
        config = Config()
        dict_ = config.get_dict()
        if config.first_time:
            force_setup = True

        if force_setup:
            dict_ = config.build()
            Template.render(config)
            # config.init_letsencrypt()
            # Setup.update_hosts(dict_)
        else:
            print ("Running smoothly")
            # if config.auto_detect_network():
            #     Template.render(config)
            #     Setup.update_hosts(dict_)

        Command.start()

if __name__ == '__main__':
   
    try:
        if len(sys.argv) > 2:
            CLI.colored_print("Bad syntax. Try 'run.py --help'",
                                   CLI.COLOR_ERROR)
        elif len(sys.argv) == 2:
            if sys.argv[1] == '-h' or sys.argv[1] == '--help':
                Command.help()   
                Updater.run(cron=True, update_self=update_self)
            elif sys.argv[1] == '-s' or sys.argv[1] == '--setup':
                run(force_setup=True)
            elif sys.argv[1] == '-S' or sys.argv[1] == '--stop':
                Command.stop()
    #         elif sys.argv[1] == '-l' or sys.argv[1] == '--logs':
    #             Command.logs()
    #         elif sys.argv[1] == '-v' or sys.argv[1] == '--version':
    #             Command.version()
            else:
                CLI.colored_print("Bad syntax. Try 'run.py --help'",
                                  CLI.COLOR_ERROR)
        else:
            run()
    except KeyboardInterrupt:
        CLI.colored_print('\nUser interrupted execution', CLI.COLOR_INFO)