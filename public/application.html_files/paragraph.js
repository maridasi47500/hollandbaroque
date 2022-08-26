crossmarx.define("paragraph", [], function() {
	
	function paragraph() {
		
		var SELF = this;
		
		this.init = function(event) {
			
			// PARAGRAPH SMALL - OFF - DOES NOTHING NOW
			
			/*
			// SET SMALLPANE CLASS - TO WRAP ELEMENTS
			if ( $(SELF).width() < crossmarx.tools.breakpoint.small ){
				$(SELF).addClass('smallPane');
			} else {
				$(SELF).removeClass('smallPane');
			}
			*/
		}
		SELF.init();
		//crossmarx.onWindowResize(SELF.init, 250);
	}
	this.create = paragraph;
});