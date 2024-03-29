	/*
	@var i string default
	@var l how many repeat s
	@var s string to repeat
	@var w where s should indent
	*/
	jQuery.cu_strPad = function(i,l,s,w) {
		var o = i.toString();
		if (!s) { s = '0'; }
		while (o.length < l) {
			// empty
			if(w == 'undefined'){
				o = s + o;
			}else{
				o = o + s;
			}
		}
		return o;
	};


	jQuery('a.debug-report').click(function(){

		var report = "";

		jQuery('.report_table thead, .report_table tbody').each(function(){

			if ( jQuery( this ).is('thead') ) {

				report = report + "\n### " + jQuery.trim( jQuery( this ).text() ) + " ###\n\n";

			} else {

				jQuery('tr', jQuery( this )).each(function(){

					var the_name    = jQuery.cu_strPad( jQuery.trim( jQuery( this ).find('td:eq(0)').text() ), 25, ' ' );
					var the_value   = jQuery.trim( jQuery( this ).find('td:eq(1)').text() );
					var value_array = the_value.split( ', ' );

					if ( value_array.length > 1 ){

						// if value have a list of plugins ','
						// split to add new line
						var output = '';
						var temp_line ='';
						jQuery.each( value_array, function(key, line){
							var tab = ( key == 0 )?0:25;
							temp_line = temp_line + jQuery.cu_strPad( '', tab, ' ', 'f' ) + line +'\n';
						});

						the_value = temp_line;
					}

					report = report +''+ the_name + the_value + "\n";
				});

			}
		} );

		try {
			jQuery("#debug-report").slideDown();
			jQuery("#debug-report textarea").val( report ).focus().select();
			jQuery(this).fadeOut();
			return false;
		} catch(e){ console.log( e ); }

		return false;
	});
