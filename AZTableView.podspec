
Pod::Spec.new do |s|


  s.name         = "AZTableView"
  s.version      = "0.0.1"
  s.summary      = "TicketEk to purchase tickets"

  s.description  = "Ticketek to purchase events tickets in one place just integrate it with you app and you are good to go."

  s.homepage     = "http://www.google.com"

  s.platform         = :ios, "8.0"
  s.license      = "MIT"


  s.author             = { "" => "" }

  s.source       = { :git => "git@bitbucket.org:yinzcamsmartfile/ticketek_ios.git" }



 
  s.source_files = 'Pod/**/*.{m,h,swift,xcassets}'
  s.resource_bundles = {
     'TicketEkElements' => ['Pod/**/*.{storyboard,xib,xcassets}']
  }


  s.resources    = 'Pod/StoryBoards/Ticketek.storyboard'

  s.dependency  "Alamofire"
  #s.dependency  "PageMenu"
  s.dependency  "JTTableViewController"
  s.dependency  "JTProgressHUD"
  s.dependency  "MTBBarcodeScanner"
  #s.dependency  "FAParser"
  s.dependency  "Shimmer"
  s.dependency  "SDCAlertView"

end
