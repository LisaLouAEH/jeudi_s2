require 'rubygems'
require 'nokogiri'
require 'open-uri'

def depute_email(name, email)

    hash = Hash.new
    # this loop store both tab name and url properly in a wonderful hash_tab :
    i= 0
    while i < name.size
        hash.store(name[i], email[i])
        i += 1
    end
    return hash
end
#--------------------------------------------------------------------------------------
def get_name(page)
    @name = []
    #deputes-list
    page.css('//div/div/ul/li/a').grep(/M/).each do |node|
        @name << node.text
    end
    puts "get_name ok"
    return @name
end
#-------------------------------------------------------------------------------------
def get_url(page)
    @url = []
    #recupere les urls de chaque fiches deputé et les stockent dans un tableau
    page.css('//@href').grep(/OMC_PA/).each do |node|
        @url << node.to_s.gsub("/deputes/", "http://www2.assemblee-nationale.fr/deputes/")
    end
    puts "get_url ok"
    return @url
end
#-------------------------------------------------------------------------------------
def get_email(url)
    @email = []
    #recupere les emails dans chaque fiche de deputés par le bouton contact
    url.each do |page|
        page = Nokogiri::HTML(open(page))
        page.css('//@href').grep(/mailto/).each do |node|
            puts node.to_s.gsub("mailto:", "")
            @email << node.to_s.gsub("mailto:", "")
        end
    end
    puts @email
    return @email
end
#------------------------------------------------------------------------------------

#perform ouvre la page principale 
#puis appelle la fonction depute_email avec 2 arguments 
#car cette fonction transforme des tab en 1 seul hash.
#le contenu de ces 2 hash sont les returns de la fonction get_name et get_email
#cest deux fonction la generent des tableaux 
#qui se remplissent avec le scrapping de ce qu'on leurs mets en paramettre
def perform(page_web)
    hash = depute_email(get_name(page_web), get_email(get_url(page_web)))
    puts "Le programme fonctionne !!!!!!!!!!!!!!!!!"
    return hash

end

print perform(Nokogiri::HTML(open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique')))