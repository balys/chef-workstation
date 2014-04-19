name             'wordpress'
maintainer       'copyright-entity'
maintainer_email 'balys@balys.net'
license          'Apache 2.0'
description      'Installs/Configures wordpress'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apache2'
depends 'mysql'
depends 'php'
depends "database"
