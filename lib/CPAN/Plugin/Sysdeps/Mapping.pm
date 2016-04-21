package CPAN::Plugin::Sysdeps::Mapping;

use strict;
use warnings;

sub mapping {
    (
#	# for UUID (seen for dist LZAP/UUID-0.05.tar.gz) and for Data::UUID::LibUUID
#	package { "e2fsprogs-libuuid": ensure => installed }
#	# for XML::LibXSLT
#	package { "libxslt": ensure => installed }
#	# for HTML::Tidy
#	package { "tidyp": ensure => installed }
#	# for Linux::Inotify2
#	package { "libinotify": ensure => installed }
#	# for DNS::LDNS
#	package { "ldns": ensure => installed }
#	# for Text::Aspell
#	# "aspell" alone is not enough, test needs also English directories
#	package { "aspell": ensure => installed }
#	package { "en-aspell": ensure => installed }
#	# for File::MimeInfo
#	# actually, this module installs without the package, but
#        # depending modules like IO-All which really use it may fail
#	package { "shared-mime-info": ensure => installed }
#	# provides pkg-config, needed by various modules (e.g.
#        # Alien-RRDtool)
#	package { "pkgconf": ensure => installed }
#	# for Imager: optional but useful dependencies (freetype2 is also useful for Tk)
#	package { "freetype2": ensure => installed }
#	package { "giflib-nox11": ensure => installed }
#	package { "png": ensure => installed }
#	package { "tiff": ensure => installed }
#	package { "jpeg": ensure => installed }
#        # for Imager::Font::T1
#	package { "t1lib": ensure => installed }
#	# for Net::LibIDN
#	package { "libidn": ensure => installed }
#	# for Cairo and Prima::Cairo
#	package { "cairo": ensure => installed }
#	# for Pango
#	package { "pango": ensure => installed }
#	# probably needed by Alien-Uninum
#	package { "gmp": ensure => installed }
#	# for Text-VimColor
#	package { "vim": ensure => installed }
#	# for Tk, Prima...
#	package { "libX11": ensure => installed }
#	# for XFT support in Tk
#	package { "libXft": ensure => installed }
#	# for Gimp module
#	package { "gimp-app": ensure => installed }
#	# for DBD::Pg
#	package { "postgresql93-server": ensure => installed }
#	# for Alien::libtermkey and Alien::unibilium
#	if $lsbdistcodename == "squeeze" or $lsbdistcodename == "wheezy" {
#	    package { "libtool": ensure => installed }
#	} else {
#	    package { "libtool-bin": ensure => installed }
#        }
#	# for JavaScript::V8
#	package { "v8": ensure => installed }
#	## for Archive::Rar
#	## -> restricted, no binary package available, must build from ports
#	#package { "rar": ensure => installed }
#	# for BerkeleyDB - db48 matches the current distroprefs file for freebsd-10
#	package { "db48": ensure => installed }
#	# for Net::SSH2 and Git::Raw
#	package { "libssh2": ensure => installed }
#	# not needed for Git::Raw - should be already bundled - package { "libgit2": ensure => installed }
#	# for Locale::gettext (gettext distribution)
#	package { "gettext": ensure => installed }
#	# TeX stuff
#	if !$common::small_disk {
#	    # for Template::Plugin::Latex, LaTeX::Driver (and probably other latex-using modules)
#	    ## package { "teTeX-base": ensure => installed } --- old, not anymore in ports - see https://svnweb.freebsd.org/ports?view=revision&revision=362648 and https://forums.freebsd.org/threads/tetex-removed-from-ports-tex-live-is-now-the-default-tex.47334/
#            package { "texlive-base": ensure => installed }
#	    # for LaTeX::Driver (and probably other latex-using modules)
#	    ## package { "dvipsk-tetex": ensure => installed } - XXX replacement?
#            package { "tex-formats": ensure => installed }
#        }
#	# for Mail::OpenDKIM
#	package { "opendkim": ensure => installed }
#	# for ZMQ::FFI (seems to hang with nonthreaded perls on freebsd, wait-and-kill rule exists)
#	package { "libzmq4": ensure => installed }
#	# for Sys::Virt (but the latest Sys::Virt usually needs the latest libvirt)
#	package { "libvirt": ensure => installed }
#	# for some Judy-using modules (probably)
#	package { "Judy": ensure => installed }
#	# for Math::GSL
#	package { "gsl": ensure => installed }
#	## various rpm using tools
#	## XXX disabled because package was not yet built (last check 2014-08-10)
#	## see http://portsmon.freebsd.org/portoverview.py?category=archivers&portname=rpm5
#	#package { "rpm5": ensure => installed }
#	# for GnuPG::Interface
#        # XXX what about gnupg (version 2)?
#	package { "gnupg1": ensure => installed }
#	# for Template-Plugin-React
#	package { "swig13": ensure => installed }
#	# for Crypt::Sodium
#	package { "libsodium": ensure => installed }
#	# theoretically for Alien::FFTW3 (but does not work anyway); for Math::FFTW
#	package { "fftw3": ensure => installed }
#	# for GraphViz
#	package { "graphviz": ensure => installed }
#	# for X::Osd
#	package { "xosd": ensure => installed }
#	# for Alien::ffmpeg
#	package { "yasm": ensure => installed }
#	# for Git::XS
#	package { "libgit2": ensure => installed }
#	# for Wx
#	package { "wx30-gtk2": ensure => installed }
#	# for Gtk3
#	package { "gtk3": ensure => installed }
#        package { "dbus": ensure => installed }
#        include freebsd_dbus
#	# for DBD::ODBC
#	package { "unixODBC": ensure => installed }
#	# for Image::Magick (but typically needs manual work)
#	package { "ImageMagick": ensure => installed }
#	## for Inline::Lua (does not work, see https://rt.cpan.org/Ticket/Display.html?id=93690, therefore not active)
#	#package { "lua": ensure => installed }
#	# for DBD::Firebird
#	package { "firebird25-server": ensure => installed }
#	## theoretically for Net::LibNIDS, but does not work (no libnids.so in freebsd port, just .a)
#	#package { "libnids": ensure => installed }
#	#package { "libnet": ensure => installed }
#	# for Tcl (compiles, but the tests hang for perls 5.18.x and newer)
#	package { "tcl84": ensure => installed }
#	# for MIDI::ALSA
#	package { "alsa-lib": ensure => installed }
#	package { "alsa-utils": ensure => installed }
#	# for Net::Libdnet
#	package { "libdnet": ensure => installed }
#	# for Image::PNGwriter
#	package { "pngwriter": ensure => installed }
#	# for Image::LibRSVG
#	package { "librsvg2": ensure => installed }
#	# for Image::Resize::OpenCV
#	package { "opencv": ensure => installed }
#	# for Astro::FITS::CFITSIO
#	package { "cfitsio": ensure => installed }
#	# for Crypt::Cracklib
#	package { "cracklib": ensure => installed }
#	# for Image::GeoTIFF::Tiled (additionally tiff is needed)
#	package { "libgeotiff": ensure => installed }
#	# for Ogg::Vorbis::Decoder
#	package { "libvorbis": ensure => installed }
#	# for Poppler
#	package { "poppler": ensure => installed }
#	package { "poppler-glib": ensure => installed }
#	# for Spread (net/spread also exists, refering to version 3, but tests seem to pass with version 4)
#	package { "spread4": ensure => installed }
#	# for Sys::Hwloc
#	package { "hwloc": ensure => installed }
#	# for Video::FFmpeg
#	package { "ffmpeg": ensure => installed }
#	# for Sword
#	package { "sword": ensure => installed }
#	# for ZOOM::IRSpy
#	package { "yaz": ensure => installed }
#	# for Lib::IXP
#	package { "libixp": ensure => installed }
#	# for CDB::TinyCDB
#	package { "tinycdb": ensure => installed }
#	# for Deliantra::Client
#	package { "sdl2": ensure => installed }
#	package { "sdl2_image": ensure => installed }
#	package { "sdl2_mixer": ensure => installed }
#	# for DVD::Read
#	package { "libdvdread": ensure => installed }
#	# for Alien::SVN
#	package { "apr": ensure => installed }
#	# for Gnome2
#	package { "libgnomeui": ensure => installed }
#	# for Gnome2::Canvas
#	package { "libgnomecanvas": ensure => installed }
#	# for Gnome2::GConf
#	package { "gconf2": ensure => installed }
#	# for Gnome2::VFS
#	package { "gnome-vfs": ensure => installed }
#	# for IPC::MMA
#	package { "mm": ensure => installed }
#	# for Heimdal::Kadm5
#	package { "heimdal": ensure => installed }
#	# for Graphics::GnuplotIF
#	if !$common::small_disk {
#	    # gnuplot deps include texlive-texmf and texlive-base, all deps take more than 1GB of space
#	    package { "gnuplot": ensure => installed }
#	}
#	# for Bio::SCF
#	package { "io_lib": ensure => installed }
#	# for CSS::Croco
#	package { "libcroco": ensure => installed }
#	# for Device::Velleman::K8055::libk8055
#	package { "libk8055": ensure => installed }
#	if false {
#	    # for EFL --- build is not successful anyway (Evas.h cannot be found), additionally the prereqs install also gcc on a freebsd10 system
#	    package { "evas-core": ensure => installed }
#	    package { "elementary": ensure => installed }
#	}
#	# for Net::DBus::GLib
#	package { "dbus-glib": ensure => installed }
#	# for Audio::FLAC::Decoder
#	package { "flac": ensure => installed }
#	# for Graphics::SANE
#	package { "sane-backends": ensure => installed }
#	# for Compress::LZMA::Simple
#	package { "lzmalib": ensure => installed }
#	# for File::Rdiff
#	package { "librsync": ensure => installed }
#	# for Math::RngStream
#	package { "rngstreams": ensure => installed }
#	# for MP3::ID3Lib
#	package { "id3lib": ensure => installed }
#	# for Text::Kakasi
#	package { "ja-kakasi": ensure => installed }
#	# for XML::Xerces ("You must use Xerces-C-2.7.0")
#	package { "xerces-c2": ensure => installed }
#	# for Gnome2::Wnck
#	package { "libwnck": ensure => installed }
#	# for File::Scan::ClamAV
#	package { "clamav": ensure => installed }
#	# for Lucene
#	package { "clucene": ensure => installed }
#	# for Math::GAP
#	if !$common::small_disk {
#	    # needs >1GB of disk space
#	    package { "gap": ensure => installed }
#	}
#	# for Cache::Memcached::XS
#	package { "libmemcache": ensure => installed }
#	# for Graphics::Plotter
#	package { "plotutils": ensure => installed }
#	# for Image::Ocrad
#	package { "ocrad": ensure => installed }
#	# for Inline::Ruby
#	package { "ruby": ensure => installed }
#	## for Math::GammaFunction
#	## NOTE don't install it --- see .cpan/prefs/01.DISABLED.yml why
#	#if $kernelversion >= 10 {
#	#    # don't install package, because it has gcc as a dependency, which is unwanted on 10.0 smokers
#	#} else {
#	#    package { "libRmath": ensure => installed }
#	#}
#	# for Net::Jabber::Loudmouth
#	package { "loudmouth": ensure => installed }
#	# for Net::oRTP
#	package { "ortp": ensure => installed }
#	# for Parallel::Pvm
#	package { "pvm": ensure => installed }
#	# for Search::Namazu
#	package { "namazu3": ensure => installed }
#	# for Search::Odeum
#	package { "qdbm": ensure => installed }
#	# for Speech::Recognizer::SPX
#	package { "pocketsphinx": ensure => installed }
#	# for Sys::Gamin
#	package { "gamin": ensure => installed } # note: possible conflict with fam
#	# for Text::CSV::LibCSV
#	package { "libcsv": ensure => installed }
#	# for Text::Migemo
#	package { "ja-migemo": ensure => installed }
#	# for XML::WBXML
#	package { "wbxml2": ensure => installed }
#	# for Math::MPC
#	package { "mpc": ensure => installed }
#	# for Date::LibICal
#	package { "libical": ensure => installed }
#	# for RPC::Xmlrpc_c::Client
#	package { "xmlrpc-c": ensure => installed }
#	# for Crypt::MCrypt
#	package { "libmcrypt": ensure => installed }
#	# for Term::EditLine
#	package { "libedit": ensure => installed }
#	# for Audio::GSM
#	package { "gsm": ensure => installed }
#	# for Mail::DMARC::opendmarc
#	package { "opendmarc": ensure => installed }
#	# for Finance::MICR::GOCR::Check
#	package { "gocr": ensure => installed }
#	# for various SVN:: modules
#	package { "subversion": ensure => installed }
#	# for X11::XCB
#	package { "xcb-util-wm": ensure => installed }
#	# various modules using java
#	if !$common::small_disk {
#	    package { "openjdk8": ensure => installed }
#        }
#	## Text::BibTeX --- not needed: btparse is bundled in the distribution
#	#package { "btparse": ensure => installed }
#	# for UDT::Simple
#	package { "udt": ensure => installed }
#	# for Net::ZooKeeper and ZooKeeper
#	if !$common::small_disk { # needs java
#	    package { "libzookeeper": ensure => installed }
#        }
#	# for Crypt::OTR
#	package { "libotr": ensure => installed }
#	# for XML::Saxon::XSLT2
#	if !$common::small_disk { # needs java
#	    package { "saxon-he": ensure => installed }
#        }
#	# for Event::Lib
#	package { "libevent2": ensure => installed }
#	# for Config::Augeas
#	package { "augeas": ensure => installed }
#	# for Audio::TagLib
#	package { "taglib": ensure => installed }
#	# for Net::WDNS
#	package { "wdns": ensure => installed }
#	# for EV::ADNS
#	package { "adns": ensure => installed }
#	# for Gearman::XS
#	if !$common::small_disk { # needs boost-libs
#	    package { "gearmand": ensure => installed }
#        }
#	## for Database::Cassandra::Client --- but does not work, and neither does cassandra2
#	#package { "cassandra": ensure => installed }
#        # for Passwd::Keyring::Gnome
#        package { "gnome-keyring": ensure => installed }
#	# for Inline::Python
#	package { "python": ensure => installed }
#	# for Unix::Statgrab
#	package { "libstatgrab": ensure => installed }
#        # for LMDB_File
#        package { "lmdb": ensure => installed }
#	# for DateTime-Astro
#	package { "mpfr": ensure => installed }
#        # for Net-Silk
#        package { "silktools": ensure => installed }
#        # for Tree::Suffix
#        package { "libstree": ensure => installed }
#        # for Cache::RedisDB (real testing with redis-server)
#        package { "redis": ensure => installed }
#        # for Glib::Object::Introspection
#        package { "gobject-introspection": ensure => installed }
#        # for HTTP::Soup::Gnome
#        package { "libsoup-gnome": ensure => installed }
#        # for NanoMsg::Raw
#        package { "nanomsg": ensure => installed }
#        # for HTML::CTPP2
#        package { "ctpp2": ensure => installed }
#        # Store::CouchDB (tests pass also without, but most tests are skipped)
#        package { "couchdb": ensure => installed }
#        # Text::Bidi (otherwise real tests are skipped) (anyway,
#        # version of fribidi available in 2015-04 is too old, so tests
#        # are still skipped)
#        package { "fribidi": ensure => installed }
#	# for Goo::Canvas
#	package { "goocanvas": ensure => installed }
#        # for Text::Hunspell
#        package { "hunspell": ensure => installed }
#        # for Search::Xapian
#        package { "xapian-core": ensure => installed }
#        # for Geo::Hex::V3::XS
#        package { "cmake": ensure => installed }
#        # for Term::VTerm
#        package { "libvterm": ensure => installed }
#        # for WWW::Mechanize::PhantomJS
#        package { "phantomjs": ensure => installed }
#        # for DateLocale
#        package { "gettext-tools": ensure => installed }
#        # for Pod::Weaver::Plugin::Ditaa
#        package { "ditaa": ensure => installed }
#        # for Audio::LibSampleRate
#        package { "libsamplerate": ensure => installed }
#        # for WWW::Bootstrap
#        package { "npm": ensure => installed }
#        # for LibJIT
#        package { "libjit": ensure => installed }
#        # for Net::RabbitMQ::Client
#        package { "rabbitmq-c-devel": ensure => installed }
#        # for Geo::Shapelib
#        package { "shapelib": ensure => installed }
#        # for Image::Imlib2
#        package { "imlib2": ensure => installed }
#        # for Image::Libpuzzle
#        package { "libpuzzle": ensure => installed }
#        # for Alien::HDF4
#        package { "hdf": ensure => installed }
#        # for Tie::Cvs
#        package { "cvs": ensure => installed }
#	# for OpenGL
#	package { "freeglut": ensure => installed }
#        # for Net::LibNIDS (but does not work)
#        package { "libpcap": ensure => installed }
#        package { "libnids": ensure => installed }
#        ## for Bio::HTSTools - htslib exists, but does not seem to be compatible with the perl module
#        #package { "htslib": ensure => installed }
#        ## for Audio::Extract::PCM --- does not work, see https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=205732
#        #package { "sox": ensure => installed }
#        # for SNMP::OID::Translate
#        package { "net-snmp": ensure => installed }
#        # for Libssh::Session (compiles only with freebsd 10, but not with freebsd 9)
#        package { "libssh": ensure => installed }
#        # for Alien::ProtoBuf (but why? shouldn't an alien module care about its own module?)
#        package { "protobuf": ensure => installed }
#        # for MaxMind::DB::Reader::XS (but tests fail)
#        package { "libmaxminddb": ensure => installed }
#        # for XML::Sablotron (compiles only with perl < 5.14, see https://rt.cpan.org/Ticket/Display.html?id=66849)
#        package { "Sablot": ensure => installed }
#        # for Hiredis::Raw
#        package { "hiredis": ensure => installed }
#        # for PulseAudio
#        package { "pulseaudio": ensure => installed }
#        # for Google::ProtocolBuffers::Dynamic
#        package { "protobuf": ensure => installed }
#        # for Archive::SevenZip
#        package { "p7zip": ensure => installed }
####### END FreeBSD #####
#    } elsif $operatingsystem == "Debian" {
####### Debian #####
#	# for Net::SSLeay and Crypt::OpenSSL::Random
#	package { "libssl-dev": ensure => installed }
#	# for XML::Parser
#	package { "libexpat1-dev": ensure => installed }
#	# for Net::ZooKeeper
#	if $lsbdistcodename == "squeeze" {
#	    # not available
#	} else {
#	    package { "libzookeeper-mt-dev": ensure => installed }
#	    package { "zookeeperd": ensure => installed }
#	}
#	# for Crypt::DH::GMP
#	if $lsbdistcodename == "squeeze" {
#	    package { "libgmp3-dev": ensure => installed }
#	} else {
#	    package { "libgmp-dev": ensure => installed }
#	}
#	# for GraphViz
#	package { "graphviz": ensure => installed }
#	# for Fuse
#	package { "libfuse-dev": ensure => installed }
#	# check: gdbm needed for XML::LibXSLT ?!
#	# for Git::XS
#	if $lsbdistcodename == "squeeze" {
#	    # not available
#	} elsif $lsbdistcodename == "wheezy" {
#	    # not available
#	} else {
#	    package { "libgit2-dev": ensure => installed }
#	}
#	# for SVN::Hooks
#	package { "subversion": ensure => installed }
#	# for Algorithm::ConstructDFA::XS and Algorithm::LibLinear
#	package { "g++": ensure => installed }
#	# for Alien::LibYAML
#	package { "autoconf": ensure => installed }
#	# for Alien::SVN
#	package { "libapr1-dev": ensure => installed }
#	# for Alien::SVN
#	package { "libaprutil1-dev": ensure => installed }
#	# for Alien::libtermkey
#	package { "libncurses5-dev": ensure => installed }
#	# for Alien::libtermkey and Alien::unibilium
#	package { "libtool": ensure => installed }
#	# for Alien::wxWidgets
#	package { "libgtk2.0-dev": ensure => installed }
#	# for DBD::Firebird
#	package { "firebird-dev": ensure => installed }
#	# for DB_File and BerkeleyDB
#	if $::lsbdistcodename == 'squeeze' {
#	    package { "libdb4.8-dev": ensure => installed }
#	} elsif $::lsbdistcodename == 'wheezy' {
#	    package { "libdb5.1-dev": ensure => installed }
#	} else {
#	    package { "libdb5.3-dev": ensure => installed }
#        }
#	# for Term::ReadLine::Gnu
#	package { "libreadline6-dev": ensure => installed }
#	# for URPM (but does not work anyway with the librpm version as found on squeeze)
#	package { "librpm-dev": ensure => installed }
#	# for UUID
#	package { "uuid-dev": ensure => installed }
#	# for X11::GUITest
#	package { "libxt-dev": ensure => installed }
#	package { "libxtst-dev": ensure => installed }
#	# for XML::LibXSLT
#	package { "libxslt1-dev": ensure => installed }
#	# for Text::Aspell
#	package { "libaspell-dev": ensure => installed }
#	# for ZMQ::FFI
#	package { "libzmq-dev": ensure => installed }
#	# for Net::SSH2 (and maybe Git::Raw)
#	package { "libssh2-1-dev": ensure => installed }
#	# for Net-NfDump
#	package { "flex": ensure => installed }
#	# for Net-NfDump
#	package { "byacc": ensure => installed }
#	# for DateTime-Astro
#	package { "libmpfr-dev": ensure => installed }
#	if $lsbdistcodename == "squeeze" {
#	    # for Image::PNGwriter
#	    package { "libpngwriter0-dev": ensure => installed }
#	} # not available in wheezy
#	# for Math::GSL
#	package { "libgsl0-dev": ensure => installed }
#	# for Image::LibRSVG
#	package { "librsvg2-dev": ensure => installed }
#	# for Image::Resize::OpenCV
#	package { "libcv-dev": ensure => installed }
#	# for Astro::FITS::CFITSIO
#	package { "libcfitsio3-dev": ensure => installed }
#	# for Crypt::Cracklib
#	package { "libcrack2-dev": ensure => installed }
#	## for Image::GeoTIFF::Tiled XXX conflict between libtiff5 and libtiff4, cannot use this
#	#package { "libgeotiff-dev": ensure => installed }
#	# for Tk::TIFF
#	if $::lsbdistcodename == "squeeze" or $::lsbdistcodename == "wheezy" {
#	    package { "libtiff4-dev": ensure => installed }
#        } else {
#	    package { "libtiff5-dev": ensure => installed }
#        }
#	# for Image::LibExif
#	package { "libexif-dev": ensure => installed }
#	# for Ogg::Vorbis::Decoder
#	package { "libvorbis-dev": ensure => installed }
#	# for Poppler
#	package { "libpoppler-dev": ensure => installed }
#	package { "libpoppler-glib-dev": ensure => installed }
#	if $lsbdistcodename == "squeeze" {
#	    # for Spread
#	    package { "libspread1-dev": ensure => installed }
#	} # not available in wheezy
#	# for Sys::Hwloc
#	package { "libhwloc-dev": ensure => installed }
#	# various Tcl+Tk stuff
#	package { "tcl8.5-dev": ensure => installed }
#	package { "tk8.5-dev": ensure => installed }
#	# for Video::FFmpeg
#	package { "ffmpeg": ensure => installed }
#	# for Sword
#	package { "libsword-dev": ensure => installed }
#	# for Tcl::Tk (snit package)
#	package { "tcllib": ensure => installed }
#	# for ZOOM::IRSpy
#	package { "libyaz4-dev": ensure => installed }
#	# for Lib::IXP
#	package { "libixp": ensure => installed }
#	# for CDB::TinyCDB
#	package { "libcdb-dev": ensure => installed }
#	# for FTDI::D2XX (XXX does not work?)
#	package { "libftdi-dev": ensure => installed }
#	# for Deliantra::Client
#	package { "libsdl1.2-dev": ensure => installed }
#	package { "libsdl-image1.2-dev": ensure => installed }
#	package { "libsdl-mixer1.2-dev": ensure => installed }
#	# for DVD::Read
#	package { "libdvdread-dev": ensure => installed }
#	# for Gnome2
#	package { "libgnomeui-dev": ensure => installed }
#	# for Gnome2::Canvas
#	package { "libgnomecanvas2-dev": ensure => installed }
#	# for Gnome2::GConf
#	package { "libgconf2-dev": ensure => installed }
#	# for Gnome2::VFS
#	package { "libgnomevfs2-dev": ensure => installed }
#	# for IPC::MMA
#	package { "libmm-dev": ensure => installed }
#	## for Heimdal::Kadm5 XXX conflicts with libkrb5-dev
#	#package { "heimdal-dev": ensure => installed }
#	# for Graphics::GnuplotIF
#	package { "gnuplot": ensure => installed }
#	# for CSS::Croco
#	package { "libcroco3-dev": ensure => installed }
#	# for Net::DBus::GLib
#	package { "libdbus-glib-1-dev": ensure => installed }
#	# for Lingua::NATools
#	package { "sqlite3": ensure => installed }
#	# for Compress::Raw::Lzma
#	package { "liblzma-dev": ensure => installed }
#	# for Compress::LZO
#	package { "liblzo2-dev": ensure => installed }
#	# for Audio::FLAC::Decoder
#	package { "libflac-dev": ensure => installed }
#	# for Graphics::SANE (no chance for pass reports) and Sane (has pass reports)
#	package { "libsane-dev": ensure => installed }
#	## for Compress::LZMA::Simple (looks like this is the wrong dependency, does not work with wheezy/jessie)
#	#package { "lzma-dev": ensure => installed }
#	# for File::Rdiff
#	package { "librsync-dev": ensure => installed }
#	# for MP3::ID3Lib
#	package { "libid3-3.8.3-dev": ensure => installed }
#	# for Text::Kakasi (but there are linking errors on Debian)
#	package { "libkakasi2-dev": ensure => installed }
#	## for XML::Xerces XXX probably needs setting of XERCES_* variables?
#	# package { "libxerces-c2-dev": ensure => installed }
#	# for Gnome2::Wnck
#	package { "libwnck-dev": ensure => installed }
#	## for File::Scan::ClamAV
#        ## XXX disabled because it occupies some 150MB of data, but package
#        ## XXX does not look maintained for more than five years.
#        ## XXX ClamAV::Client does not have any tests.
#	#package { "clamav-daemon": ensure => installed }
#	#package { "clamav-data": ensure => installed }
#	# for Lucene
#	package { "libclucene-dev": ensure => installed }
#	# for Math::GAP
#        # rationale for this condition: Math::GAP had no release since 2007,
#        # so it's probably stable (in a biologist sense...). Additionally,
#        # I don't plan to add more perl versions to cvrsnica-freebsd-92. So
#        # safe >1.2GB by not requiring this package...
#        if $::hostname != "cvrsnica-freebsd-92" {
#	    package { "gap": ensure => installed }
#        }
#	# for Cache::Memcached::XS
#	if $::lsbdistcodename == "squeeze" or $::lsbdistcodename == "wheezy" {
#	     package { "libmemcache-dev": ensure => installed }
#        } else {
#             # in jessie there's no package containing include/memcache.h
#        }
#	# for Graphics::Plotter
#	package { "plotutils": ensure => installed }
#	# for Inline::Ruby
#	if $::lsbdistcodename == "squeeze" or $::lsbdistcodename == "wheezy" {
#	    package { "ruby1.8-dev": ensure => installed }
#        } else {
#	    package { "ruby2.1-dev": ensure => installed }
#        }
#	# for Math::FFTW, theoretically also for Alien::FFTW3 (but does not work because of too low version in Debian/squeeze)
#	package { "libfftw3-dev": ensure => installed }
#	# for Net::Jabber::Loudmouth
#	package { "libloudmouth1-dev": ensure => installed }
#	# for Net::oRTP
#	package { "libortp-dev": ensure => installed }
#	# for Parallel::Pvm
#	package { "pvm-dev": ensure => installed }
#	# for Search::Odeum
#	package { "libqdbm-dev": ensure => installed }
#	# for Sys::Gamin
#	package { "libfam-dev": ensure => installed }
#	# for XML::WBXML
#	package { "libwbxml2-dev": ensure => installed }
#	# for MIDI::ALSA
#	package { "alsa-utils": ensure => installed }
#	# for modperl2
#	if $::lsbdistcodename == "squeeze" or $::lsbdistcodename == "wheezy" {
#	    package { "apache2-prefork-dev": ensure => installed }
#        } else {
#            # jessie and later
#	    package { "apache2-dev": ensure => installed }
#        }
#	# for Template::Plugin::Latex (and probably other latex-using modules)
#	package { "texlive-latex-base": ensure => installed }
#	# for LaTeX::Driver (and probably other latex-using modules)
#	package { "texlive-latex-extra": ensure => installed }
#	# for Pod::Spelling
#	package { "ispell": ensure => installed }
#	# for Math::MPC
#	package { "libmpc-dev": ensure => installed }
#	# for Alien::LibUSBx
#	package { "libudev-dev": ensure => installed }
#	# for Date::LibICal
#	package { "libical-dev": ensure => installed }
#	# for RPC::Xmlrpc_c::Client
#	if $::lsbdistcodename == "squeeze" or $::lsbdistcodename == "wheezy" {
#	    package { "libxmlrpc-c3-dev": ensure => installed }
#        } else {
#	    package { "libxmlrpc-core-c3-dev": ensure => installed }
#        }
#	# Crypt::MCrypt -> XXX not available in debian/squeeze
#	# for Term::EditLine
#	package { "libedit-dev": ensure => installed }
#	# for Audio::GSM
#	package { "libgsm1-dev": ensure => installed }
#	# for Mail::DMARC::opendmarc -> XXX not available in debian/squeeze and in debian/wheezy
#	# for File::LibMagic
#	package { "libmagic-dev": ensure => installed }
#	# various wordnet-using modules
#	package { "wordnet-base": ensure => installed }
#	# for Archive::Rar
#	package { "rar": ensure => installed }
#	# for PerlQt
#	if $lsbdistcodename == "squeeze" {
#	    package { "libqt3-mt-dev": ensure => installed }
#	} # no libqt3 anymore for wheezy
#	# for Image::Magick
#	package { "libmagickcore-dev": ensure => installed }
#	# for Finance::MICR::GOCR::Check
#	package { "gocr": ensure => installed }
#	# for Math::MPFI
#	package { "libmpfi-dev": ensure => installed }
#	# for Image::SubImageFind
#	package { "libmagick++-dev": ensure => installed }
#	# for Authen::SASL::Cyrus
#	package { "libsasl2-dev": ensure => installed }
#	# for Hobocamp
#	package { "dialog": ensure => installed }
#	package { "libncursesw5-dev": ensure => installed }
#	# for Crypt::OTR
#	if $::lsbdistcodename == "squeeze" or $::lsbdistcodename == "wheezy" {
#	    package { "libotr2-dev": ensure => installed }
#        } else {
#	    package { "libotr5-dev": ensure => installed }
#        }
#	# for AI::PBDD (but does not work, kernel.h is also required)
#	package { "libbdd-dev": ensure => installed }
#	# for Device::Cdio (but still does not work)
#	package { "libcdio-dev": ensure => installed }
#	package { "libiso9660-dev": ensure => installed }
#	# for Inline::Java
#	if $::lsbdistcodename == "squeeze" {
#	    package { "openjdk-6-jdk": ensure => installed }
#        } else {
#	    package { "openjdk-7-jdk": ensure => installed }
#        }
#	# for DLM::Client
#	package { "libdlm-dev": ensure => installed }
#	# for OpenGL::FTGL (but does not work, lookup into wrong freetype directory)
#	package { "libftgl-dev": ensure => installed }
#	package { "libfreetype6-dev": ensure => installed }
#	# for Goo::Canvas
#	package { "libgoocanvas-dev": ensure => installed }
#	# for Bio::Phylo::Beagle
#	package { "libhmsbeagle-dev": ensure => installed }
#	# for Audio::SndFile
#	package { "libsndfile1-dev": ensure => installed }
#	# for SGML::Parser::OpenSP
#	package { "libosp-dev": ensure => installed }
#	# for PAM
#	package { "libpam0g-dev": ensure => installed }
#	# for EV::ADNS
#	package { "libadns1-dev": ensure => installed }
#	# for Linux::Prctl
#	package { "libcap-dev": ensure => installed }
#	# for Audio::PortAudio XXX conflicts with libjack0
#	# package { "portaudio19-dev": ensure => installed }
#	# for Net::SIGTRAN::SCTP
#	package { "libsctp-dev": ensure => installed }
#	# for Chipcard::PCSC
#	package { "libpcsclite-dev": ensure => installed }
#	# for GSM::Gnokii
#	package { "libgnokii-dev": ensure => installed }
#	# for Imager::Font::T1
#	if $::lsbdistcodename == "squeeze" or $::lsbdistcodename == "wheezy" {
#	    package { "libt1-dev": ensure => installed }
#        } else {
#            # not available anymore since jessie?
#        }
#	# for X11::XCB
#	package { "xsltproc": ensure => installed }
#	package { "libxcb-util0-dev": ensure => installed }
#	package { "libxcb-xinerama0-dev": ensure => installed }
#	package { "libxcb-icccm4-dev": ensure => installed }
#	# for gimp module # 90 MB for package + deps
#	package { "libgimp2.0-dev": ensure => installed }
#	# for UDT::Simple
#	package { "libudt-dev": ensure => installed }
#	# for Math::GammaFunction
#	# not for small disks, installs about ~85MB
#	if !$common::small_disk {
#	    package { "r-mathlib": ensure => installed }
#	}
#	# for Bio::SCF
#	package { "libstaden-read-dev": ensure => installed }
#	# for Glib::Object::Introspection
#	package { "libgirepository1.0-dev": ensure => installed }
#	# for Gtk3
#	package { "libgtk-3-dev": ensure => installed }
#	# for Linux::ACL
#	package { "libacl1-dev": ensure => installed }
#	# for Unix::Statgrab (unfortunately does not work in wheezy, the library version is too old for the module)
#	package { "libstatgrab-dev": ensure => installed }
#	# for Inline::Python
#	package { "python2.7-dev": ensure => installed }
#	# for Event::Lib
#	package { "libevent-dev": ensure => installed }
#	# for OpenGL
#	package { "freeglut3-dev": ensure => installed }
#        package { "libxmu-dev": ensure => installed }
#	# for Config::Augeas (but the wheezy version is too old, module wants 1.0.0, wheezy has 0.10.0)
#	package { "libaugeas-dev": ensure => installed }
#	# for Audio::TagLib (but does not work, because the module wants taglib 1.9.1, but wheezy has 1.7.2-1)
#	package { "libtag1-dev": ensure => installed }
#	# for Net::LibAsyncNS
#	package { "libasyncns-dev": ensure => installed }
#	# for Gearman::XS
#	package { "libgearman-dev": ensure => installed }
#	# for Qstruct
#	package { "ragel": ensure => installed }
#        # for Curses::UI::Mousehandler::GPM
#        package { "libgpm-dev": ensure => installed }
#        # for HTTP::Soup::Gnome
#        package { "libsoup-gnome2.4-dev": ensure => installed }
#       	# for Crypt::Sodium
#	if $::lsbdistcodename == "squeeze" or $::lsbdistcodename == "wheezy" {
#            # not available before jessie
#        } else {
#	    package { "libsodium-dev": ensure => installed }
#        }
#        # for Term::VTerm
#	if $::lsbdistcodename == "squeeze" or $::lsbdistcodename == "wheezy" {
#            # currently (2015-10) only available in experimental
#            # (which is included in my jessie&sid VMs)
#        } else {
#            package { "libvterm-dev": ensure => installed }
#        }
#        # for Linux::Systemd::Journal
#        if $::lsbdistcodename == 'sid' {
#            package { "libsystemd-dev": ensure => installed }
#        } else {
#            package { "libsystemd-journal-dev": ensure => installed }
#        }
#        # for Cache::RedisDB (real testing with redis-server)
#        package { "redis-server": ensure => installed }
#        # for NanoMsg::Raw
#	if $::lsbdistcodename == "squeeze" or $::lsbdistcodename == "wheezy" {
#            # not available before jessie
#        } else {
#            package { "libnanomsg-dev": ensure => installed }
#        }
#        # for HTML::CTPP2
#	if $::lsbdistcodename == "squeeze" or $::lsbdistcodename == "wheezy" {
#            # not available before jessie
#        } else {
#            package { "libctpp2-dev": ensure => installed }
#        }
#        # Store::CouchDB (tests pass also without, but most tests are skipped)
#        if $::lsbdistcodename == 'jessie' {
#            # not available in jessie, just wheezy and sid
#        } else {
#            package { "couchdb": ensure => installed }
#        }
#        # Text::Bidi (otherwise real tests are skipped, but on wheezy
#        # the library is too old, so tests are anyway skipped)
#        package { "libfribidi-dev": ensure => installed }
#        # for Text::Hunspell
#        package { "libhunspell-dev": ensure => installed }
#        # for Search::Xapian
#        package { "libxapian-dev": ensure => installed }
#        # for Geo::Hex::V3::XS
#        package { "cmake": ensure => installed }
#        # for Net::Pcap (also needed for Net::LibNIDS)
#        package { "libpcap0.8-dev": ensure => installed }
#        # for WWW::Mechanize::PhantomJS
#        # no package available, but see https://gist.github.com/julionc/7476620
#	# for Net::Libdnet
#        # XXX but does not work without applying the patch manually - see https://rt.cpan.org/Ticket/Display.html?id=106021
#	package { "libdumbnet-dev": ensure => installed }
#	# for Mail::OpenDKIM
#	package { "libopendkim-dev": ensure => installed }
#        # for Pod::Weaver::Plugin::Ditaa
#        package { "ditaa": ensure => installed }
#        # for Audio::LibSampleRate
#        package { "libsamplerate0-dev": ensure => installed }
#        # for Geo::Shapelib
#        package { "libshp-dev": ensure => installed }
#        # for Image::Imlib2
#        package { "libimlib2-dev": ensure => installed }
#        # for Image::Libpuzzle
#        package { "libpuzzle-dev": ensure => installed }
#        # for Tie::Cvs
#        package { "cvs": ensure => installed }
#        # for Linux::Sysfs
#        package { "libsysfs-dev": ensure => installed }
#        # for Net::LibNIDS
#        package { "libnids-dev": ensure => installed }
#        package { "libnet1-dev": ensure => installed }
#        # for Audio::Extract::PCM
#        package { "sox": ensure => installed }
#        # for SNMP::OID::Translate (but tests fail)
#        package { "libsnmp-dev": ensure => installed }
#        # for Libssh::Session (but does not work)
#        package { "libssh-dev": ensure => installed }
#        # for Alien::ProtoBuf (but why? shouldn't an alien module care about its own module?)
#        package { "libprotobuf-dev": ensure => installed }
#	# for DBD::ODBC
#	package { "unixodbc-dev": ensure => installed }
#        # for LMDB_File
#	if $::lsbdistcodename == "squeeze" or $::lsbdistcodename == "wheezy" {
#            # not available before jessie
#        } else {
#            package { "liblmdb-dev": ensure => installed }
#        }
#        # for SNMP::OID::Translate
#        package { "snmp-mibs-downloader": ensure => installed }
#        # for Hiredis::Raw
#        package { "libhiredis-dev": ensure => installed }
#        # for PulseAudio
#        package { "pulseaudio": ensure => installed }
#        # for Google::ProtocolBuffers::Dynamic
#        package { "libprotoc-dev": ensure => installed }
#        # for Archive::SevenZip
#        package { "p7zip-full": ensure => installed }
####### END Debian #####
#    } elsif ($operatingsystem == "RedHat") { # includes CentOS
#	# for XML::LibXSLT - unfortunately the version which comes with epel for CentOS6 is not sufficient
#	package { "libxslt-devel": ensure => installed }


     [
      #cpandist => qr{^(Cairo-\d|Prima-Cairo-\d)}, # XXX base id or full dist name with author?
      cpanmod => ['Cairo', 'Prima::Cairo'],
      [os => 'freebsd',
       [package => 'cairo']],
      [linuxdistro => '~debian',
       [package => 'libcairo2-dev']]],

#     [cpandist => qr{^(Cairo-\d|Prima-Cairo-\d)}, # XXX base id or full dist name with author?
#      sub {
#	  my($self, $dist) = @_;
#	  if ($dist->base_id =~ m{^(Cairo-\d|Prima-Cairo-\d)}) {
#	      if ($^O eq 'freebsd') {
#		  return { package => 'cairo' };
#	      } elsif ($^O eq 'linux' && $self->{linuxdistro} =~ m{^(debian|ubuntu|linuxmint)$}) {
#		  return { package => 'libcairo2-dev' };
#	      }
#	  }
#      }],
    );
}

1;
