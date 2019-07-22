<!-- Skroutz Analytics Order Products Script start -->
{if ($order->module == "codfee")}  {* Replace "codfee" with your module name for cach on delivery fee *}
<script>
	{literal}
			{/literal}
				{$free_shipping = 49}      //Replace with your free shipping starting price
				{$codfee_tax_inc = 2}      //Replace with your codfee tax included
				{$codfee_tax_exc = 1.6129} //Replace with your codfee tax excluded
			{literal}
			skroutz_analytics('ecommerce', 'addOrder', JSON.stringify({
			order_id:    '{/literal}{$order->id|escape:'htmlall':'UTF-8'}{literal}',                                                                // Order ID. Required.
			revenue:     '{/literal}{$order->total_products_wt + $order->total_shipping_tax_incl - $codfee_tax_inc}{literal}',	  // Grand Total. Includes Tax and Shipping.
			{/literal}{if ($order->total_products_wt <= $free_shipping)}{literal} 
				shipping:    '{/literal}{$order->total_shipping_tax_incl - $codfee_tax_inc}{literal}', // Total Shipping Cost.
			{/literal}{else}{literal}
				shipping:    '{/literal}{$order->total_shipping_tax_incl}{literal}',   // Total Shipping Cost.
			{/literal}{/if}{literal}
			tax:         '{/literal}{$taxamt = ($order->total_paid_tax_incl - $codfee_tax_inc) - ($order->total_paid_tax_excl - $codfee_tax_exc)}{$taxamt}{literal}'	// Total Tax.
		}));
	{/literal}
</script>
{else}
<script>
	{literal}
			skroutz_analytics('ecommerce', 'addOrder', JSON.stringify({
			order_id:    '{/literal}{$order->id}{literal}',                                                                // Order ID. Required.
			revenue:     '{/literal}{$order->total_products_wt + $order->total_shipping_tax_incl}{literal}',	  // Grand Total. Includes Tax and Shipping.
			shipping:    '{/literal}{$order->total_shipping_tax_incl}{literal}',                                                // Total Shipping Cost.
			tax:         '{/literal}{$taxamt = $order->total_paid_tax_incl - $order->total_paid_tax_excl}{$taxamt}{literal}'	// Total Tax.
		}));
	{/literal}
</script>
{/if} 
<script>
{foreach from=$order_products item=product}

		{literal}
			skroutz_analytics('ecommerce', 'addItem', JSON.stringify({
			order_id:   '{/literal}{$order->id}{literal}',                  // Order ID. Required.
			product_id: '{/literal}{$product.product_id}{literal}',              // Product ID. Required.
			name:       '{/literal}{$product.product_name}{literal}',            // Product Name. Required.
			price:      '{/literal}{$product.product_price_wt}{literal}',    // Price per Unit. Required.
			quantity:   '{/literal}{$product.product_quantity}{literal}'         // Quantity of Items. Required.
	  		}));
	  	{/literal}

{/foreach}
</script>
<!-- Skroutz Analytics Order Products Script end -->
