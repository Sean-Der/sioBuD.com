$(document).ready(function() {
	jQuery.fn.animateAuto = function(prop, speed, callback){
				var elem, height, width;
				return this.each(function(i, el){
	    		el = jQuery(el), elem = el.clone().css({'height':'auto','width':'auto'}).appendTo('body');
	    		height = elem.css('height'),
	    		width = elem.css('width'),
	    		elem.remove();
	  			
					if(prop === 'height')
	       	 el.animate({'height':height}, speed, callback);
	    		else if(prop === 'width')
	       		el.animate({'width':width, 'marginLeft' : "-125px"}, speed, callback);  
	    		else if(prop === 'both')
	        	el.animate({'width':width,'height':height}, speed, callback);
			});  
		}
	
	$('body').on('click', '.centered-image',function(){
		curWidth = parseInt($(this).css('width').replace('px', ''));
		if (curWidth < 800){
			$(this).animateAuto('width', 1000); 
		} else {
			$(this).animate({
				width: '95%', 
				'marginLeft' : "0px"
			}, 1000);
		}
	});
})
