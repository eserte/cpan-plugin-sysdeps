package CPAN::Plugin::Sysdeps::Mapping;

use strict;
use warnings;

our $VERSION = '0.02';

# shortcuts
use constant os_freebsd  => (os => 'freebsd');
use constant like_debian => (linuxdistro => '~debian');

sub mapping {
    (
     [cpanmod => 'AI::PBDD',
      [os_freebsd,
       # but does not work, kernel.h is also required
       [package => 'bddsolve']],
      [like_debian,
       # but does not work, kernel.h is also required
       [package => 'libbdd-dev']]],

     [cpanmod => ['Algorithm::ConstructDFA::XS', 'Algorithm::LibLinear'],
      # FreeBSD has c++ in the base system
      [like_debian,
       [package => 'g++']],
     ],

     [cpanmod => 'Alien::ffmpeg',
      [os_freebsd,
       [package => 'yasm']],
      [like_debian,
       [package => 'yasm']],
     ],

     [cpanmod => 'Alien::FFTW3',
      [os_freebsd,
       [package => ['fftw3', 'pkgconf']]],
      [like_debian,
       [package => 'libfftw3-dev', 'pkg-config | pkgconf']]],

     [cpanmod => 'Alien::HDF4',
      [os_freebsd,
       [package => 'hdf']],
      [like_debian,
       # "yasm/nasm not found or too old. Use --disable-yasm for a crippled build."
       [package => 'yasm']],
     ],

     [cpanmod => 'Alien::LibUSBx',
      # XXX what about freebsd?
      [like_debian,
       [package => 'libudev-dev']]],

     [cpanmod => 'Alien::LibYAML',
      [like_debian,
       [package => 'autoconf']],
      # XXX what about freebsd?
     ],

     [cpanmod => 'Alien::libtermkey',
      [os_freebsd,
       [package => ['libtool', 'gmake', 'pkgconf']]],
      [like_debian,
       [linuxdistrocodename => ['squeeze','wheezy'],
	[package => ['libtool', 'libncurses5-dev']]],
       [package => ['libtool-bin', 'libncurses5-dev']]],
      # XXX what about freebsd?
     ],

     [cpanmod => 'Alien::ProtoBuf',
      # but why? shouldn't an alien module care about its own external library?
      [os_freebsd,
       [package => 'protobuf']],
      [like_debian,
       [package => 'libprotobuf-dev']]],

     [cpanmod => 'Alien::RRDtool',
      [os_freebsd,
       [package => ['pkgconf', 'glib', 'cairo', 'pango', 'libxml2']]],
      [like_debian,
       [package => 'pkg-config | pkgconf']]], # XXX pkg-config probably needed by much more CPAN distributions...

     [cpanmod => 'Alien::SVN',
      [os_freebsd,
       # does not work, configure does not recognize sqlite
       [package => ['apr', 'sqlite3']]],
      [like_debian,
       [package => ['libapr1-dev', 'libaprutil1-dev', 'libsqlite3-dev', 'zlib1g-dev']]]],

     [cpanmod => 'Alien::unibilium',
      # XXX what about freebsd?
      [os_freebsd,
       [package => ['gmake', 'libtool', 'pkgconf']]],
      [like_debian,
       [linuxdistrocodename => ['squeeze','wheezy'],
	[package => 'libtool']],
       [package => 'libtool-bin']],
     ],

     [cpanmod => 'Alien::Uninum', # probably!
      [os_freebsd,
       # XXX does not work, configure does not accept -lgmp
       [package => 'gmp']],
      # XXX what about debian?
     ],

     [cpanmod => 'Alien::uPB',
      [package => 'unzip']],

     [cpanmod => 'Alien::wxWidgets',
      [os_freebsd,
      # XXX what about freebsd?
       [package => ['gtk2', 'pkgconf']]],
      [like_debian,
       [package => 'libgtk2.0-dev']]],

     [cpanmod => 'Archive::Rar',
      [os_freebsd,
       [package => 'rar'], # restricted, no binary package available, must build from ports
      ],
      [like_debian,
       [package => 'rar'], # available in jessie/non-free
      ]],

     [cpanmod => 'Archive::SevenZip',
      [os_freebsd,
       [package => 'p7zip']],
      [like_debian,
       [package => 'p7zip-full']]],

     [cpanmod => 'Astro::FITS::CFITSIO',
      [os_freebsd,
       [package => 'cfitsio']],
      [like_debian,
       [package => 'libcfitsio3-dev']]],

     [cpanmod => 'Audio::Extract::PCM',
      # but does not work with freebsd, see https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=205732
      [package => 'sox']],

     [cpanmod => 'Audio::FLAC::Decoder',
      [os_freebsd,
       [package => 'flac']],
      [like_debian,
       [package => 'libflac-dev']]],

     [cpanmod => 'Audio::GSM',
      [os_freebsd,
       [package => 'gsm']],
      [like_debian,
       [package => 'libgsm1-dev']]],

     [cpanmod => 'Audio::LibSampleRate',
      [os_freebsd,
       [package => 'libsamplerate']],
      [like_debian,
       [package => 'libsamplerate0-dev']]],

     [cpanmod => 'Audio::PortAudio',
      [os_freebsd,
       [package => ['portaudio', 'pkgconf']]],
      [like_debian,
       # conflicts with libjack0
       [package => 'portaudio19-dev']]],

     [cpanmod => 'Audio::SndFile',
      [os_freebsd,
       [package => ['libsndfile', 'pkgconf']]],
      [like_debian,
       [package => 'libsndfile1-dev']]],

     [cpanmod => 'Audio::TagLib',
      [os_freebsd,
       [package => 'taglib']],
      [like_debian,
       # but does not work, because the module wants taglib 1.9.1, but wheezy has 1.7.2-1
       [package => ['libtag1-dev', 'g++']]]],

     [cpanmod => 'Authen::SASL::Cyrus',
      [os_freebsd,
       [package => 'cyrus-sasl']],
      [like_debian,
       [package => 'libsasl2-dev']]],

     [cpanmod => ['BerkeleyDB', 'BDB'],
      [os_freebsd,
       # FreeBSD has libdb in the base system, but this version is too old.
       # Make sure that a corresponding distroprefs file matches this library.
       [package => 'db48']],
      [like_debian,
       [linuxdistrocodename => 'squeeze',
	[package => 'libdb4.8-dev']],
       [linuxdistrocodename => 'wheezy',
	[package => 'libdb5.1-dev']],
       [package => 'libdb5.3-dev']]],

     [cpanmod => 'Bio::HTS',
      [os_freebsd,
       # htslib exists, but does not seem to be compatible with the perl module
       [package => 'htslib']],
      [like_debian,
       # also does not work...
       [package => 'libhts-dev']]],

     [cpanmod => 'Bio::Phylo::Beagle',
      # XXX what about freebsd?
      [like_debian,
       [package => ['libhmsbeagle-dev', 'pkg-config | pkgconf']]]],

     [cpanmod => 'Bio::SCF',
      [os_freebsd,
       [package => 'io_lib']],
      [like_debian,
       [package => ['libstaden-read-dev', 'zlib1g-dev']]]],

     [cpanmod => 'Cache::Memcached::XS',
      [os_freebsd,
       [package => 'libmemcache']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy'],
	[package => 'libmemcache-dev']],
       [package => []], # in jessie there's no package containing include/memcache.h
      ]],

     [cpanmod => 'Cache::RedisDB',
      # real testing with redis-server
      [os_freebsd,
       [package => 'redis']],
      [like_debian,
       [package => 'redis-server']]],

     [cpanmod => ['Cairo', 'Prima::Cairo'],
      [os_freebsd,
       [package => 'cairo']],
      [like_debian,
       [package => 'libcairo2-dev']]],

     [cpanmod => 'CDB::TinyCDB',
      [os_freebsd,
       [package => 'tinycdb']],
      [like_debian,
       [package => 'libcdb-dev']]],

     [cpanmod => 'Chipcard::PCSC',
      # XXX what about freebsd?
      [like_debian,
       [package => ['bzip2', 'libpcsclite-dev', 'pkg-config | pkgconf']]]], # bzip2 needed for extraction

     [cpanmod => ['ClamAV::Client', 'File::Scan::ClamAV'],
      [os_freebsd,
       [package => 'clamav']],
      [like_debian,
       [package => ['clamav-daemon', 'clamav-data']]]],

     [cpanmod => ['Compress::LZMA::Simple', 'Compress::Raw::Lzma'],
      [os_freebsd,
       # this one does not work with Compress::Raw::Lzma under freebsd
       [package => 'lzmalib']],
      [like_debian,
       # this one does not work with Compress::LZMA::Simple under debian
       [package => 'liblzma-dev']]],

     [cpanmod => 'Compress::LZO',
      [os_freebsd,
       [package => 'lzo2']],
      [like_debian,
       [package => 'liblzo2-dev']]],

     [cpanmod => 'Config::Augeas',
      [os_freebsd,
       [package => ['augeas', 'pkgconf']]],
      [like_debian,
       # but the wheezy version is too old, module wants 1.0.0, wheezy has 0.10.0
       [package => ['libaugeas-dev', 'pkg-config | pkgconf']]]],

     [cpanmod => 'Crypt::Cracklib',
      [os_freebsd,
       [package => 'cracklib']],
      [like_debian,
       [package => 'libcrack2-dev']]],

     [cpanmod => 'Crypt::DH::GMP',
      [os_freebsd,
       [package => 'gmp']],
      [like_debian,
       [linuxdistrocodename => 'squeeze',
	[package => 'libgmp3-dev']],
       [package => 'libgmp-dev']]],

     [cpanmod => 'Crypt::GCrypt',
      [os_freebsd,
       # Does not work, see the patches in the p5-Crypt-GCrypt port
       [package => 'libgcrypt']],
      [like_debian,
       # Neither libgcrypt11 nor libgcrypt20 seem to work.
       [package => 'libgcrypt11-dev']]],

     [cpanmod => 'Crypt::MCrypt',
      [os_freebsd,
       [package => 'libmcrypt']],
      [like_debian,
       [linuxdistrocodename => 'squeeze',
	[package => []], # N/A in squeeze
       ],
       [package => 'libmcrypt-dev']]],

     [cpanmod => ['Crypt::OpenSSL::Random', 'Net::SSLeay'],
      # freebsd has all libssl in the base system
      [like_debian,
       [package => 'libssl-dev']]],

     [cpanmod => 'Crypt::OTR',
      [os_freebsd,
       [package => 'libotr']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy'],
	[package => 'libotr2-dev']],
       [package => 'libotr5-dev']]],

     [cpanmod => 'Crypt::Sodium',
      [os_freebsd,
       [package => 'libsodium']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy'],
	[package => []], # not available before jessie
       ],
       [package => 'libsodium-dev']]],

     [cpanmod => 'CSS::Croco',
      [os_freebsd,
       [package => ['libcroco', 'pkgconf']]],
      [like_debian,
       [package => 'libcroco3-dev']]],

     [cpanmod => 'Curses::UI::Mousehandler::GPM',
      [like_debian,
       [package => ['libgpm-dev', 'libncurses5-dev']]]],

     [cpanmod => 'Database::Cassandra::Client',
      [os_freebsd,
       # but does not work, and neither does cassandra2
       [package => 'cassandra']],
      # cassandra package not available on debian
     ],

     [cpanmod => ['Data::UUID::LibUUID', 'UUID'],
      [os_freebsd,
       [package => 'e2fsprogs-libuuid']],
      [like_debian,
       [package => 'uuid-dev']]],

     [cpanmod => 'Date::LibICal',
      [os_freebsd,
       [package => 'libical']],
      [like_debian,
       [package => 'libical-dev']]],

     [cpanmod => 'DateLocale',
      [os_freebsd,
       [package => 'gettext-tools']],
      # XXX what about debian?
     ],

     [cpanmod => 'DateTime::Astro',
      [os_freebsd,
       [package => 'mpfr']],
      [like_debian,
       [package => 'libmpfr-dev']]],

     [cpanmod => 'DB_File',
      [like_debian,
       [linuxdistrocodename => 'squeeze',
	[package => 'libdb4.8-dev']],
       [linuxdistrocodename => 'wheezy',
	[package => 'libdb5.1-dev']],
       [package => 'libdb5.3-dev']],
      # FreeBSD has libdb in the base system
     ],

     [cpanmod => 'DBD::Firebird',
      [os_freebsd,
       [package => 'firebird25-server']],
      [like_debian,
       [package => 'firebird-dev']]],

     [cpanmod => 'DBD::ODBC',
      [os_freebsd,
       [package => 'unixODBC']],
      [like_debian,
       [package => 'unixodbc-dev']]],

     [cpanmod => 'DBD::Pg',
      [os_freebsd,
       [package => 'postgresql93-server']],
      [like_debian,
       [package => 'libpq-dev']]],

     [cpanmod => 'Deliantra::Client',
      [os_freebsd,
       [package => ['sdl2', 'sdl2_image', 'sdl2_mixer']]],
      [like_debian,
       [package => ['libsdl1.2-dev', 'libsdl-image1.2-dev', 'libsdl-mixer1.2-dev', 'libglib2.0-dev']]]],

     [cpanmod => 'Device::Cdio',
      [like_debian,
       # but still does not work
       [package => ['libcdio-dev', 'libiso9660-dev']]]],

     [cpanmod => 'Device::Velleman::K8055::libk8055',
      [os_freebsd,
       [package => 'libk8055']],
      # not available on debian
     ],

     [cpanmod => 'DLM::Client',
      # libdlm does not seem to exist on FreeBSD
      [like_debian,
       [package => 'libdlm-dev']]],
     
     [cpanmod => 'DNS::LDNS',
      [os_freebsd,
       [package => 'ldns']],
      [like_debian,
       [package => 'libldns-dev']]],

     [cpanmod => 'DVD::Read',
      [os_freebsd,
       [package => 'libdvdread']],
      [like_debian,
       [package => 'libdvdread-dev']]],

     [cpanmod => 'EFL',
      [os_freebsd,
       # build is not successful anyway (Evas.h cannot be found), additionally the prereqs install also gcc on a freebsd10 system
       [package => ['evas-core', 'elementary']]],
      [like_debian,
       # here too: build is not successful anyway (Evas.h cannot be found)
       [package => ['libevas-dev', 'libelementary-dev']]]],

     [cpanmod => 'EV::ADNS',
      [os_freebsd,
       [package => 'adns']],
      [like_debian,
       [package => 'libadns1-dev']]],

     [cpanmod => 'Event::Lib',
      [os_freebsd,
       [package => 'libevent2']],
      [like_debian,
       [package => 'libevent-dev']]],

     [cpanmod => 'ExtUtils::CppGuess',
      # FreeBSD has c++ in the base system
      [like_debian,
       [package => 'g++']]],

     [cpanmod => 'ExtUtils::PkgConfig',
      [os_freebsd,
       [package => 'pkgconf']],
      [like_debian,
       [package => 'pkg-config | pkgconf']]],

     [cpanmod => 'File::LibMagic',
      # XXX what about freebsd?
      [like_debian,
       [package => 'libmagic-dev']]],

     [cpanmod => 'File::MimeInfo',
      [os_freebsd,
       [# actually, this module installs without the package, but
        # depending modules like IO-All which really use it may fail
	[package => 'shared-mime-info']]]],

     [cpanmod => 'File::Rdiff',
      [os_freebsd,
       [package => 'librsync']],
      [like_debian,
       [package => 'librsync-dev']]],

     [cpanmod => 'Finance::MICR::GOCR::Check',
      [package => 'gocr']],

     [cpanmod => 'FTDI::D2XX',
      # neither libftdi nor libftdi1 seem to work on FreeBSD
      [like_debian,
       [package => 'libftdi-dev']]],

     [cpanmod => 'Fuse',
      # Fuse.pm does not work on freebsd
      [like_debian,
       [package => 'libfuse-dev']]],

     [cpanmod => 'GD',
      [os_freebsd,
       [package => 'gd']],
      [like_debian,
       [linuxdistrocodename => ['precise'],
	[package => 'libgd-noxpm-dev | libgd2-xpm-dev']],
       [package => 'libgd-dev']]],

     [cpanmod => 'Gearman::XS',
      [os_freebsd,
       [package => 'gearmand-devel'], # untested; not for small disks, needs boost-libs
      ],
      [like_debian,
       [package => 'libgearman-dev']]],

     [cpanmod => 'Geo::Hex::V3::XS',
      [package => 'cmake']],

     [cpanmod => 'Geo::Shapelib',
      [os_freebsd,
       [package => 'shapelib']],
      [like_debian,
       [package => 'libshp-dev']]],

     [cpanmod => 'Gimp',
      [os_freebsd,
       [package => 'gimp-app']],
      [like_debian,
       [package => 'libgimp2.0-dev'], # 90 MB for package + deps
      ]],

     [cpanmod => 'Git::Raw',
      [os_freebsd,
       [package => 'libssh2']],
      [like_debian,
       [package => 'libssh2-1-dev']],
      # libgit2 is already bundled with Git::Raw
     ],

     [cpanmod => 'Git::XS',
      [os_freebsd,
       [package => 'libgit2']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy'],
	[package => []]], # N/A
       [package => 'libgit2-dev']]],

     [cpanmod => 'Glib::Object::Introspection',
      [os_freebsd,
       [package => 'gobject-introspection']],
      [like_debian,
       [package => 'libgirepository1.0-dev']]],

     [cpanmod => 'Gnome2',
      [os_freebsd,
       [package => 'libgnomeui']],
      [like_debian,
       [package => 'libgnomeui-dev']]],

     [cpanmod => 'Gnome2::Canvas',
      [os_freebsd,
       [package => 'libgnomecanvas']],
      [like_debian,
       [package => 'libgnomecanvas2-dev']]],

     [cpanmod => 'Gnome2::GConf',
      [os_freebsd,
       [package => 'gconf2']],
      [like_debian,
       [package => 'libgconf2-dev']]],

     [cpanmod => 'Gnome2::Wnck',
      [os_freebsd,
       [package => 'libwnck']],
      [like_debian,
       [package => 'libwnck-dev']]],

     [cpanmod => 'Gnome2::VFS',
      [os_freebsd,
       [package => 'gnome-vfs']],
      [like_debian,
       [package => 'libgnomevfs2-dev']]],

     [cpanmod => 'GnuPG::Interface',
      [os_freebsd,
       [package => 'gnupg1'] #  XXX what about gnupg (version 2)?
      ],
      # XXX what about debian?
     ],

     [cpanmod => 'Goo::Canvas',
      [os_freebsd,
       [package => 'goocanvas']],
      [like_debian,
       [package => 'libgoocanvas-dev']]],

     [cpanmod => 'Google::ProtocolBuffers::Dynamic',
      [os_freebsd,
       [package => 'protobuf']],
      [like_debian,
       [package => 'libprotoc-dev']]],

     [cpanmod => 'Graphics::GnuplotIF',
      [package => 'gnuplot']],

     [cpanmod => 'Graphics::Plotter',
      [os_freebsd,
       [package => 'plotutils']],
      [like_debian,
       [package => 'libplot-dev']]],

     [cpanmod => ['Graphics::SANE', 'Sane'],
      [os_freebsd,
       [package => 'sane-backends']],
      [like_debian,
       [package => 'libsane-dev']]],

     [cpanmod => 'GraphViz',
      # package named the same in freebsd and debian, maybe everywhere?
      [package => 'graphviz']],

     [cpanmod => 'GSM::Gnokii',
      # XXX what about freebsd?
      [like_debian,
       [package => 'libgnokii-dev']]],

     [cpanmod => 'Gtk3',
      [os_freebsd,
       # additionally dbus has to be enabled and started
       [package => ['gtk3', 'dbus']]],
      [like_debian,
       [package => 'libgtk-3-dev']]],

     [cpanmod => 'Heimdal::Kadm5',
      [os_freebsd,
       [package => 'heimdal']],
      [like_debian,
       # conflicts with libkrb5-dev
       [package => 'heimdal-dev']]],

     [cpanmod => 'Hiredis::Raw',
      [os_freebsd,
       [package => 'hiredis']],
      [like_debian,
       [package => 'libhiredis-dev']]],

     [cpanmod => 'Hobocamp',
      # XXX what about freebsd
      [like_debian,
       [package => ['dialog', 'libncursesw5-dev']]]],

     [cpanmod => 'HTML::CTPP2',
      [os_freebsd,
       [package => 'ctpp2']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy'],
	[package => []], # not available before jessie
       ],
       [package => 'libctpp2-dev']]],

     [cpanmod => 'HTML::Tidy',
      [os_freebsd,
       [package => 'tidyp']],
      # linux: Alien::Tidyp works fine, no external dependency required
     ],

     [cpanmod => 'HTTP::Soup::Gnome',
      [os_freebsd,
       [package => 'libsoup-gnome']],
      [like_debian,
       [package => 'libsoup-gnome2.4-dev']]],

     [cpanmod => 'Image::GeoTIFF::Tiled',
      [os_freebsd,
       [package => ['libgeotiff', 'tiff']]],
      [like_debian,
       [package => ['libgeotiff-dev']]], # conflict between libtiff4 and libtiff5 possible
     ],

     [cpanmod => 'Image::Imlib2',
      [os_freebsd,
       [package => 'imlib2']],
      [like_debian,
       [package => 'libimlib2-dev']]],

     [cpanmod => 'Image::LibExif',
      [os_freebsd,
       [package => 'libexif']],
      [like_debian,
       [package => 'libexif-dev']]],

     [cpanmod => 'Image::Libpuzzle',
      [os_freebsd,
       [package => 'libpuzzle']],
      [like_debian,
       [package => 'libpuzzle-dev']]],

     [cpanmod => 'Image::LibRSVG',
      [os_freebsd,
       [package => 'librsvg2']],
      [like_debian,
       [package => 'librsvg2-dev']]],

     [cpanmod => 'Image::Magick',  # typically needs manual work
      [os_freebsd,
       [package => 'ImageMagick']],
      [like_debian,
       [package => 'libmagickcore-dev']]],

     [cpanmod => 'Image::PNGwriter',
      [os_freebsd,
       [package => 'pngwriter']],
      [like_debian,
       [linuxdistrocodename => 'squeeze',
	[package => 'libpngwriter0-dev']],
       # not available in wheezy and later
       ]],

     [cpanmod => 'Image::Ocrad',
      [package => 'ocrad']],

     [cpanmod => 'Image::Resize::OpenCV',
      [os_freebsd,
       [package => 'opencv']],
      [like_debian,
       [package => ['libcv-dev', 'libhighgui-dev']]]],

     [cpanmod => 'Image::SubImageFind',
      # XXX what about freebsd?
      [like_debian,
       [package => ['libmagick++-dev', 'graphicsmagick-libmagick-dev-compat']]]],

     [cpanmod => 'Imager',
      [os_freebsd,
       [package => [qw(freetype2 giflib-nox11 png tiff jpeg)]]],
      [like_debian,
       [linuxdistrocodename => 'wheezy',
	[package => [qw(libfreetype6-dev libgif-dev libpng12-dev libjpeg-dev), 'libtiff5-dev | libtiff4-dev']]],
       [package => [qw(libfreetype6-dev libgif-dev libpng12-dev libjpeg-dev libtiff5-dev)]]],
     ],

     [cpanmod => 'Imager::Font::T1',
      [os_freebsd,
       [package => 't1lib']],
      [linuxdistro => 'linuxmint',
       [package => 'libt1-dev']], # still available in Mint 17
      [like_debian,
       linuxdistrocodename => [qw(squeeze wheezy)],
       [package => 'libt1-dev']],
      # not available anymore since jessie
      # XXX TBD how's the state in Ubuntu?
     ],

     [cpanmod => 'Inline::Java',
      [os_freebsd,
       [package => 'openjdk8']],
      [like_debian,
       [linuxdistrocodename => 'squeeze',
	[package =>  'openjdk-6-jdk']],
       [package => 'openjdk-7-jdk']]],

     [cpanmod => 'Inline::Lua',
      [os_freebsd,
       # does not work, see https://rt.cpan.org/Ticket/Display.html?id=93690
       [package => 'lua']],
      [like_debian,
       [package => 'liblua5.1-0-dev']]],

     [cpanmod => 'Inline::Python',
      [os_freebsd,
       [package => 'python']],
      [like_debian,
       [package => 'python2.7-dev']]],

     [cpanmod => 'Inline::Ruby',
      [os_freebsd,
       [package => 'ruby']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy'],
	[package => 'ruby1.8-dev']],
       [package => 'ruby2.1-dev']]],

     [cpanmod => 'IPC::MMA',
      [os_freebsd,
       [package => 'mm']],
      [like_debian,
       [package => 'libmm-dev']]],

     [cpanmod => 'JavaScript::V8',
      [os_freebsd,
       [package => 'v8']],
      # XXX what about debian?
     ],

#	# for some Judy-using modules (XXX which one?)
#	package { "Judy": ensure => installed } # XXX this is freebsd; what about debian?

     # XXX needs verification; maybe more latex-related modules should be listed here?
     [cpanmod => ['LaTeX::Driver', 'Template::Plugin::Latex'],
      [os_freebsd,
       [package => ['texlive-base', 'tex-formats']]],
      [like_debian,
       [package => ['texlive-latex-base', 'texlive-latex-extra']]]],

     [cpanmod => 'Lib::IXP',
      [package => 'libixp']],

     [cpanmod => 'LibJIT',
      [os_freebsd,
       [package => 'libjit']],
      # XXX what aout debian?
     ],

     [cpanmod => 'Libssh::Session',
      [os_freebsd,
       # compiles only with freebsd 10, but not with freebsd 9
       [package => 'libssh']],
      [like_debian,
       # but does not work
       [package => 'libssh-dev']]],

     [cpanmod => 'Lingua::NATools',
      # XXX what about freebsd?
      [like_debian,
       [package => 'sqlite3']]],

     [cpanmod => 'Linux::ACL',
      [like_debian,
       [package => 'libacl1-dev']]],

     [cpanmod => 'Linux::Inotify2',
      [os_freebsd,
       [package => 'libinotify']],
      [like_debian,
       [package => 'libc6-dev']]],

     [cpanmod => 'Linux::Prctl',
      [like_debian,
       [package => 'libcap-dev']]],

     [cpanmod => 'Linux::Sysfs',
      [like_debian,
       [package => 'libsysfs-dev']]],

     [cpanmod => 'Linux::Systemd::Journal',
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy', 'jessie'],
	[package => 'libsystemd-journal-dev']],
       # sid and probably stretch
       [package => 'libsystemd-dev']]],

     [cpanmod => 'LMDB_File',
      [os_freebsd,
       [package => 'lmdb']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy'],
	[package => []], # not available before jessie
       ],
       [package => 'liblmdb-dev']]],

     [cpanmod => 'Locale::gettext', # gettext distribution
      [os_freebsd,
       [package => 'gettext']],
      # XXX what about debian?
     ],

     [cpanmod => 'Lucene',
      [os_freebsd,
       [package => 'clucene']],
      [like_debian,
       [package => 'libclucene-dev']]],

     [cpanmod => 'Mail::DMARC::opendmarc',
      [os_freebsd,
       [package => 'opendmarc']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy'],
	[package => []]],
       [package => 'libopendmarc-dev']]],

     [cpanmod => 'Mail::OpenDKIM',
      [os_freebsd,
       [package => 'opendkim']],
      [like_debian,
       [package => 'libopendkim-dev']]],

     [cpanmod => 'Math::FFTW',
      [os_freebsd,
       [package => 'fftw3']],
      [like_debian,
       [package => 'libfftw3-dev']]],

     [cpanmod => 'Math::GammaFunction',
      [os_freebsd,
       # NOTE there's an entry in .cpan/prefs/01.DISABLED.yml
       [package => 'libRmath']],
      [like_debian,
       # not for small disks, installs about ~85MB
       [package => 'r-mathlib']]],

     [cpanmod => 'Math::GAP',
      [package => 'gap'], # needs 1-1.2GB of disk space
     ],

     [cpanmod => 'Math::GSL',
      [os_freebsd,
       [package => 'gsl']],
      [like_debian,
       [package => 'libgsl0-dev']]],

     [cpanmod => 'Math::MPC',
      [os_freebsd,
       [package => 'mpc']],
      [like_debian,
       [package => 'libmpc-dev']]],

     [cpanmod => 'Math::MPFI',
      # XXX what about freebsd?
      [like_debian,
       [package => 'libmpfi-dev']]],

     [cpanmod => 'Math::RngStream',
      [os_freebsd,
       [package => 'rngstreams']],
      # XXX what about debian?
     ],

     [cpanmod => 'MaxMind::DB::Reader::XS',
      [os_freebsd,
       # but tests fail
       [package => 'libmaxminddb']],
      # XXX what about debian?
     ],

     [cpanmod => 'MIDI::ALSA',
      [os_freebsd,
       [package => ['alsa-lib', 'alsa-utils']]],
      [like_debian,
       [package => 'alsa-utils']]],

     [cpanmod => 'MP3::ID3Lib',
      [os_freebsd,
       [package => 'id3lib']],
      [like_debian,
       [package => 'libid3-3.8.3-dev']]],

     [cpanmod => 'modperl2',
      # XXX what about freebsd?
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy'],
	[package => 'apache2-prefork-dev']],
       [package => 'apache2-dev']]],

     [cpanmod => 'NanoMsg::Raw',
      [os_freebsd,
       [package => 'nanomsg']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy'],
	[package => []], # not available before jessie
       ],
       [package => 'libnanomsg-dev']]],

     [cpanmod => 'Net::DBus::GLib',
      [os_freebsd,
       [package => 'dbus-glib']],
      [like_debian,
       [package => 'libdbus-glib-1-dev']]],

     [cpanmod => 'Net::Jabber::Loudmouth',
      [os_freebsd,
       [package => 'loudmouth']],
      [like_debian,
       [package => 'libloudmouth1-dev']]],

     [cpanmod => 'Net::Libdnet',
      [os_freebsd,
       [package => 'libdnet']],
      [like_debian,
       # but does not work without applying the patch manually - see https://rt.cpan.org/Ticket/Display.html?id=106021
       [package => 'libdumbnet-dev']]],

     [cpanmod => 'Net::LibIDN',
      [os_freebsd,
       [package => 'libidn']],
      [os => '~debian',
       [package => 'libidn11-dev']]],

     [cpanmod => 'Net::NfDump',
      [like_debian,
       [package => ['flex', 'byacc']]],
      # XXX what about freebsd?
     ],

     [cpanmod => 'Net::LibAsyncNS',
      # it seems there's no libasyncns for freebsd
      [like_debian,
       [package => 'libasyncns-dev']]],

     [cpanmod => 'Net::LibNIDS',
      [os_freebsd,
       # but does not work (no libnids.so in freebsd port, just .a)
       [package => ['libnids', 'libnet']]],
      [like_debian,
       [package => ['libnids-dev', 'libnet1-dev']]]],

     [cpanmod => 'Net::LibNIDS',
      [os_freebsd,
       # but does not work
       [package => ['libpcap', 'libnids']]],
      [like_debian,
       [package => 'libpcap0.8-dev']]],

     [cpanmod => 'Net::Pcap',
      [like_debian,
       [package => 'libpcap0.8-dev']]],

     [cpanmod => 'Net::oRTP',
      [os_freebsd,
       [package => 'ortp']],
      [like_debian,
       [package => 'libortp-dev']]],

     [cpanmod => 'Net::RabbitMQ::Client',
      [os_freebsd,
       [package => 'rabbitmq-c-devel']],
      # XXX what about debian?
     ],

     [cpanmod => 'Net::SIGTRAN::SCTP',
      # XXX what about freebsd?
      [like_debian,
       [package => 'libsctp-dev']]],

     [cpanmod => 'Net::Silk',
      [os_freebsd,
       [package => 'silktools']],
      # XXX what about debian?
     ],

     [cpanmod => 'Net::SSH2',
      [os_freebsd,
       [package => 'libssh2']],
      [like_debian,
       [package => 'libssh2-1-dev']]],

     [cpanmod => 'Net::WDNS',
      [os_freebsd,
       [package => 'wdns']],
      # XXX what about debian?
     ],

     [cpanmod => ['Net::ZooKeeper', 'ZooKeeper'],
      [os_freebsd,
       [package => 'libzookeeper']],
      [like_debian,
       [linuxdistrocodename => 'squeeze',
	[package => []]], # not available
       [package => ['libzookeeper-mt-dev', 'zookeeperd']]]],

     [cpanmod => 'NewRelic::Agent',
      # freebsd does not work, bundled .so files are linux-only
      [like_debian,
       [package => ['g++', 'libcurl3']]]],

     [cpanmod => 'Ogg::Vorbis::Decoder',
      [os_freebsd,
       [package => 'libvorbis']],
      [like_debian,
       [package => 'libvorbis-dev']]],

     [cpanmod => 'OpenGL',
      [os_freebsd,
       [package => 'freeglut']],
      [like_debian,
       [package => ['freeglut3-dev', 'libxmu-dev']]]],

     [cpanmod => 'OpenGL::FTGL',
      [like_debian,
       # but does not work, lookup into wrong freetype directory
       [package => ['libftgl-dev', 'libfreetype6-dev']]]],

     [cpanmod => 'PAM',
      [like_debian,
       [package => 'libpam0g-dev']]],

     [cpanmod => 'Pango',
      [os_freebsd,
       [package => 'pango']],
      [like_debian,
       [package => 'libpango1.0-dev']]],

     [cpanmod => 'Parallel::Pvm',
      [os_freebsd,
       [package => 'pvm']],
      [like_debian,
       [package => 'pvm-dev']]],

     [cpanmod => 'Passwd::Keyring::Gnome',
      [os_freebsd,
       [package => ['libgnome-keyring', 'pkgconf']]],
      [like_debian,
       [package => 'libgnome-keyring-dev']]],

     [cpanmod => 'PerlQt',
      [like_debian,
       [linuxdistrocodename => 'squeeze',
	[package => 'libqt3-mt-dev']],
       [package => []] # no libqt3 anymore for wheezy
      ]],

     [cpanmod => 'Pod::Spelling',
      # XXX what about freebsd?
      [like_debian,
       [package => 'ispell']]],

     [cpanmod => 'Pod::Weaver::Plugin::Ditaa',
      [package => 'ditaa']],

     [cpanmod => 'Poppler',
      [os_freebsd,
       [package => ['poppler', 'poppler-glib']]],
      [like_debian,
       [package => ['libpoppler-dev', 'libpoppler-glib-dev']]]],

     [cpanmod => 'Prima',
      # XXX what about freebsd?
      [like_debian,
       [package => [qw(libx11-dev libxpm-dev libgif-dev libpng12-dev libjpeg-dev), 'pkg-config | pkgconf']]]], # XXX maybe also add libtiff...

     [cpanmod => 'PulseAudio',
      [package => 'pulseaudio']],

     [cpanmod => 'Qstruct',
      # XXX what about freebsd?
      [like_debian,
       [package => 'ragel']]],

     [cpanmod => 'RPC::Xmlrpc_c::Client',
      [os_freebsd,
       [package => 'xmlrpc-c']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy'],
	[package => 'libxmlrpc-c3-dev']],
       [package => 'libxmlrpc-core-c3-dev']]],

#	## various rpm using tools --- XXX which one exactly?
#	## XXX disabled because package was not yet built (last check 2014-08-10)
#	## see http://portsmon.freebsd.org/portoverview.py?category=archivers&portname=rpm5
#	#package { "rpm5": ensure => installed }

     [cpanmod => 'Search::Namazu',
      [os_freebsd,
       [package => 'namazu3']],
      # XXX what about debian?
     ],

     [cpanmod => 'Search::Odeum',
      [os_freebsd,
       [package => 'qdbm']],
      [like_debian,
       [package => 'libqdbm-dev']]],

     [cpanmod => 'Search::Xapian',
      [os_freebsd,
       [package => 'xapian-core']],
      [like_debian,
       [package => 'libxapian-dev']]],

     [cpanmod => 'SGML::Parser::OpenSP',
      # XXX what about freebsd?
      [like_debian,
       [package => 'libosp-dev']]],

     [cpanmod => 'SNMP::OID::Translate',
      [os_freebsd,
       [package => 'net-snmp']],
      [like_debian,
       [package => ['libsnmp-dev', 'snmp-mibs-downloader']]]],

     [cpanmod => 'Speech::Recognizer::SPX',
      [os_freebsd,
       [package => 'pocketsphinx']],
      # XXX what about debian?
     ],

     [cpanmod => 'Spread',
      [os_freebsd,
       # net/spread also exists, refering to version 3, but tests seem to pass with version 4
       [package => 'spread4']],
      [like_debian,
       [linuxdistrocodename => 'squeeze',
	[package => 'libspread1-dev']],
       # not available in wheezy and later
      ]],

     [cpanmod => 'Store::CouchDB',
      # tests pass also without, but most tests are skipped
      [os_freebsd,
       [package => 'couchdb']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'jessie'],
	[package => []], # not available in jessie, just wheezy and sid
       ],
       [package => 'couchdb']]],

     [cpanmod => 'SVN::Hooks', # XXX maybe more SVN::* modules?
      [package => 'subversion']],

     [cpanmod => 'Sword',
      [os_freebsd,
       [package => 'sword']],
      [like_debian,
       [package => 'libsword-dev']]],

     [cpanmod => 'Sys::Gamin',
      [os_freebsd,
       [package => 'gamin'], # note: possible conflict with fam XXX maybe specify an alternative?
      ],
      [like_debian,
       [package => 'libfam-dev']]],

     [cpanmod => 'Sys::Hwloc',
      [os_freebsd,
       [package => 'hwloc']],
      [like_debian,
       [package => 'libhwloc-dev']]],

     [cpanmod => 'Sys::Virt', # but the latest Sys::Virt usually needs the latest libvirt
      [os_freebsd,
       [package => 'libvirt']],
      # XXX what about debian?
     ],

     [cpanmod => 'Tcl',
      [os_freebsd,
       # compiles, but the tests hang for perls 5.18.x and newer
       [package => 'tcl84']],
      [like_debian,
       [package => 'tcl8.5-dev']]],

     [cpanmod => 'Tcl::Tk', # XXX maybe also Tkx?
      # XXX what about freebsd?
      [like_debian,
       # tcllib is needed for the snit package
       [package => ['tk8.5-dev', 'tcllib']]]],

     [cpanmod => 'Template::Plugin::React',
      [os_freebsd,
       [package => 'swig13']],
      # XXX what about debian?
     ],

     [cpanmod => 'Term::EditLine',
      [os_freebsd,
       [package => 'libedit']],
      [like_debian,
       [package => 'libedit-dev']]],

     [cpanmod => 'Term::ReadLine::Gnu',
      [like_debian,
       [package => 'libreadline6-dev']],
      # XXX what about freebsd?
     ],

     [cpanmod => 'Term::VTerm',
      [os_freebsd,
       [package => 'libvterm']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy', 'jessie'],
	[package => []]],
       [package => 'libvterm-dev']]],

     [cpanmod => 'Text::Aspell',
      [os_freebsd,
       [# "aspell" alone is not enough, test needs also English direcotries
	package => ['aspell', 'en-aspell']]],
      [like_debian,
       [package => 'libaspell-dev']]],

     [cpanmod => 'Text::Bidi',
      # otherwise real tests are skipped
      [os_freebsd,
       # anyway, version of fribidi available in 2015-04 is too old, so tests are still skipped
       [package => 'fribidi']],
      [like_debian,
       # on wheezy the library is too old, so tests are anyway skipped
       [package => 'libfribidi-dev']]],

     [cpanmod => 'Text::CSV::LibCSV',
      [os_freebsd,
       [package => 'libcsv']],
      [like_debian,
       [package => 'libcsv-dev']]],

     [cpanmod => 'Text::Hunspell',
      [os_freebsd,
       [package => 'hunspell']],
      [like_debian,
       [package => 'libhunspell-dev']]],

     [cpanmod => 'Text::Kakasi',
      [os_freebsd,
       [package => 'ja-kakasi']],
      [like_debian,
       # but there are linking errors on Debian
       [package => 'libkakasi2-dev']]],

     [cpanmod => 'Text::Migemo',
      [os_freebsd,
       [package => 'ja-migemo']],
      [like_debian,
       [package => 'libmigemo-dev']]],

     [cpanmod => 'Text::VimColor',
      [package => 'vim']],

     [cpanmod => 'Tie::Cvs',
      [package => 'cvs']],

     [cpanmod => 'Tree::Suffix',
      [os_freebsd,
       [package => 'libstree']],
      # XXX what about debian?
     ],

     [cpanmod => 'Tk',
      [os_freebsd,
       [# freetype2 and libXft are optional, but highly recommended as it provides nicer fonts
	package => ['freetype2', 'libXft', 'libX11']]],
      # XXX what about debian?
     ],

     [cpanmod => 'Tk::TIFF',
      [os_freebsd,
       [package => 'tiff']],
      [like_debian,
       [linuxdistrocodename => ['squeeze', 'wheezy'],
	[package => 'libtiff4-dev']],
       [package => 'libtiff5-dev']]],

     [cpanmod => 'UDT::Simple',
      [os_freebsd,
       [package => 'udt']],
      [like_debian,
       [package => 'libudt-dev']]],

     [cpanmod => 'Unix::Statgrab',
      [os_freebsd,
       [package => 'libstatgrab']],
      [like_debian,
       # unfortunately does not work in wheezy, the library version is too old for the module
       [package => 'libstatgrab-dev']]],

     [cpanmod => 'URPM',
      [like_debian,
       [package => 'librpm-dev']], # but does not work anyway with the librpm version as found on squeeze
      # XXX what about freebsd?
     ],

     [cpanmod => 'Video::FFmpeg',
      [package => 'ffmpeg']], # on Debian only found in backports or www.deb-multimedia.org; still does not build because avformat.h is not available

     [cpanmod => 'WWW::Bootstrap',
      [os_freebsd,
       [package => 'npm']],
      [like_debian,
       [linuxdistrocodename => [qw(squeeze wheezy)],
	[package => []]],
       [package => 'npm']]],

     [cpanmod => 'WWW::Mechanize::PhantomJS',
      [os_freebsd,
       [package => 'phantomjs']],
      # for debian no package available, but see https://gist.github.com/julionc/7476620
     ],

     [cpanmod => 'Wx',
      [os_freebsd,
       [package => 'wx30-gtk2']],
      # XXX what about debian?
     ],

     [cpanmod => 'XML::LibXSLT',
      [os_freebsd,
       [package => 'libxslt']],
      [like_debian,
       [package => ['libxslt1-dev', 'libgdbm-dev']]],
      [linuxdistro => '~fedora',
       [package => 'libxslt-devel']]],

     [cpanmod => 'XML::Parser',
      [os_freebsd,
       [package => 'expat']],
      [like_debian,
       [package => 'libexpat1-dev']]],

     [cpanmod => 'XML::Sablotron',
      # compiles only with perl < 5.14, see https://rt.cpan.org/Ticket/Display.html?id=66849
      [os_freebsd,
       [package => 'Sablot']],
      # no sablot package on debian
     ],

     [cpanmod => 'XML::Saxon::XSLT2', # needs java
      [os_freebsd,
       [package => 'saxon-he']],
      # XXX what about debian?
     ],

     [cpanmod => 'XML::WBXML',
      [os_freebsd,
       [package => 'wbxml2']],
      [like_debian,
       [package => 'libwbxml2-dev']]],

     [cpanmod => 'XML::Xerces', # "You must use Xerces-C-2.7.0"
      [os_freebsd,
       [package => 'xerces-c2']],
      [like_debian,
       # probably needs setting of XERCES_* variables?
       [linuxdistrocodename => ['wheezy'],
	[package => 'libxerces-c2-dev']],
       [package => 'libxerces-c-dev'], # will not work, because jessie has Xerces-C-3.1.1
      ]],

     [cpanmod => 'X::Osd',
      [os_freebsd,
       [package => 'xosd']],
      [like_debian,
       [package => 'libxosd-dev']]],

     [cpanmod => 'X11::GUITest',
      [like_debian,
       [package => ['libxt-dev', 'libxtst-dev']]],
      # XXX what about freebsd
     ],

     [cpanmod => 'X11::XCB',
      [os_freebsd,
       [package => 'xcb-util-wm']],
      [like_debian,
       [package => ['xsltproc', 'xcb-proto', 'libxcb-util0-dev', 'libxcb-xinerama0-dev', 'libxcb-icccm4-dev']]]],

     [cpanmod => 'ZMQ::FFI',
      [os_freebsd,
       [package => 'libzmq4']], # seems to hang with nonthreaded perls on freebsd, wait-and-kill rule exists
      [like_debian,
       [package => 'libzmq-dev']]],

     [cpanmod => 'ZMQ::LibZMQ4',
      [os_freebsd,
       [package => 'libzmq4']], # seems to hang with nonthreaded perls on freebsd, wait-and-kill rule exists (?)
      [like_debian,
#       [linuxdistrocodename => [qw(squeeze wheezy jessie)],
#	[package => []]], # libzmq5 is ZMQ4.1 (!); according to http://zeromq.org/distro:debian only available in experimental (and probably sid)
       [package => 'libzmq3-dev'], # note: libzmq3-dev is ZMQ4.0 (!)
      ]],

     [cpanmod => 'ZOOM::IRSpy',
      [os_freebsd,
       [package => 'yaz']],
      [like_debian,
       [package => 'libyaz4-dev']]],

# XXX find out which modules:
#	# various wordnet-using modules
#	package { "wordnet-base": ensure => installed }

    );
}

1;
