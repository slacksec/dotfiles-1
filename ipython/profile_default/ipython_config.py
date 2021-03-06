import site
from os import environ
from os.path import join
from sys import version_info

if 'VIRTUAL_ENV' in environ:
    virtual_env = join(environ.get('VIRTUAL_ENV'),
            'lib',
            'python%d.%d' % version_info[:2],
            'site-packages')
    site.addsitedir(virtual_env)
    print 'Using Virtualenv =>', virtual_env
    del virtual_env
del site, environ, join, version_info


c = get_config()
c.TerminalInteractiveShell.autoedit_syntax = True
c.TerminalInteractiveShell.colors = 'Linux'
c.TerminalInteractiveShell.confirm_exit = False
c.TerminalIPythonApp.display_banner = False
c.TerminalInteractiveShell.history_length = 10000
c.TerminalInteractiveShell.autoindent = True
