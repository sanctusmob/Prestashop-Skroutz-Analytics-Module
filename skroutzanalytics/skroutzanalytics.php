<?php

if (!defined('_PS_VERSION_'))
	exit;

class skroutzAnalytics extends Module
{

	protected $_errors = array();


	public function __construct()
	{
		$this->name = 'skroutzanalytics';
		$this->tab = 'front_office_features';
		$this->version = '1.1';
		$this->author = 'Ilias S';
		$this->need_instance = 0;


		$this->bootstrap = true;


	 	parent::__construct();

		$this->displayName = $this->l('Skroutz Analytics');
		$this->description = $this->l('Adds a block.');
		$this->confirmUninstall = $this->l('Are you sure you want to delete this module?');
	}
	
	public function install()
	{
		if (!parent::install() OR
			!$this->registerHook('orderConfirmation') OR
			!$this->registerHook('header')
			)
			return false;
		return true;
	}
	
	public function uninstall()
	{
		if (!parent::uninstall())
			return false;
		return true;
	}
	
	public function getContent()
	{
		$html = '';
		
		if(Tools::isSubmit('submitUpdate'))
		{
			Configuration::updateValue('SKROUTZANALYTICS_ID', Tools::getValue('accountid'));
			$html .= $this->displayConfirmation($this->l('Settings Updated'));
		}
		
		$html .= '
		<form action="'.$SERVER['REQUEST_URI'].'" method="post" class="defaultForm form-horizontal">
			<div class="panel">
				<div class="panel-heading">'.$this->l('Settings').'</div>';
				
		$html .='
		<div class="form-group">
			<label class="control-label col-lg-3">'.$this->l('Shop Account ID').'</label>
			<div class="col-lg-6">
				<input type="text" name="accountid" value="'.Configuration::get('SKROUTZANALYTICS_ID').'">
			</div>
		</div>
		';
		
		$html .='
		<input type="submit" name="submitUpdate" value="'.$this->l('Save').'" class="btn btn-default">
		';
		
		$html .='
			</div>
		</form>
		';
		
		return $html;
	}
	
	public function hookHeader($params)
	{
		$skroutz_id = Configuration::get('SKROUTZANALYTICS_ID');
		
		$this->context->smarty->assign(array(
			'skroutz_id' => $skroutz_id
		));
		
		return $this->display(__FILE__, 'skroutzanalyticsscript.tpl');
	}


	public function hookOrderConfirmation($params)
	{
		//var_dump($params['order']);

		$order = $params['order'];
		$products = $order->getProducts();

		// var_dump($products);
		$this->context->smarty->assign(array(
			'order'=> $order,
			'order_products' => $products,
			'skroutz_id' => $skroutz_id
		));
		
		return $this->display(__FILE__, 'skroutzanalytics.tpl');
	}

	
}
