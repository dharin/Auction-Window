class HomeController < ApplicationController
  #include FaceboxRender
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login/finalize"
  end
  
  def index
    if params[:id]
      @shop = ShopifyAPI::Shop.current
      @product  = ShopifyAPI::Product.find(params[:id])

      #@auction_product = ShopifyAPI::Product.find
      # get 3 products
      @products = ShopifyAPI::Product.find(:all)

      # get latest 3 orders
      @orders   = ShopifyAPI::Order.find(:all, :params => {:limit => 3, :order => "created_at DESC" })
    end
  end

  

#  def get_for_auction
#    @current_product = ShopifyAPI::Product.find(params[:p_id])
#    @current_variant = ShopifyAPI::Variant.find(params[:v_id])
#    respond_to
#  end
end