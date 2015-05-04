Pod::Spec.new do |s|
	s.name		    	= 'EWTPollingOperation'
	s.version	    	= '0.1.0'
	s.summary		    = 'iOS: Simple polling operation with NSTimer.'
	s.homepage	  	= 'https://github.com/EwyynTomato/EWTPollingOperation.git'
	s.author	    	= { 'EwyynTomato' => 'elwyyntomato+github@gmail.com' }
	s.license 	  	= 'MIT'
	s.platform		  = :ios, '6.0'
	s.requires_arc	= true
	s.source	    	= { :git => 'https://github.com/EwyynTomato/EWTPollingOperation.git', :tag => s.version.to_s }
	s.source_files	= 'EWTPollingOperation/*.{h,m}'
end
