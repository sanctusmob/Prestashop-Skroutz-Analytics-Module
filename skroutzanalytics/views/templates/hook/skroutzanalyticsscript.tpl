<!-- Skroutz Analytics Script start -->
<script>
	{literal}
	  (function(a,b,c,d,e,f,g){a['SkroutzAnalyticsObject']=e;a[e]= a[e] || function(){
	    (a[e].q = a[e].q || []).push(arguments);};f=b.createElement(c);f.async=true;
	    f.src=d;g=b.getElementsByTagName(c)[0];g.parentNode.insertBefore(f,g);
	  })(window,document,'script','https://skroutza.skroutz.gr/skroutza.min.js','skroutz_analytics');
	
	  skroutz_analytics('session', 'connect', '{/literal}{$skroutz_id|escape:'htmlall':'UTF-8'}{literal}');  // Connect your Account.
	{/literal}
</script>
<!-- Skroutz Analytics Script end -->
