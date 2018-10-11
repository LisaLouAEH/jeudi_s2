require 'rubygems'
require 'nokogiri'
require 'open-uri'

def tab_crypto(page)
    crypto_name = []
    crypto_value = []
    crypto_hash = Hash.new
    #------------------------>store crypto names in a tab<----------------
    page.css('a.currency-name-container.link-secondary').each do |node|
        crypto_name << node.text
    end
    #------------------------>store values in a tab<---------------------
    page.css('[@class="price"]').each do |node|
        crypto_value << node.text
    end
    #------->store both tab in a hash where crypto names are keys and crypto values are values<------
    i=0
    while i<crypto_name.size
        crypto_hash.store(crypto_name[i], crypto_value[i])
        i += 1
    end
    return crypto_hash
end

def perform
    return tab_crypto(Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/')))
end
puts perform