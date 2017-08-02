
Pod::Spec.new do |s|


  s.name         = "AZTableView"
  s.version      = "0.0.2"
  s.summary      = "Automatic pagination handling and loading views"

  s.description  = <<-DESC
        Automatic pagination handling
        No more awkward empty TableView
    DESC

  s.homepage     = "https://github.com/AfrozZaheer/AZTableView"

  s.platform         = :ios, "8.0"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }


  s.author       = { "AfrozZ" => "afrozezaheer@gmail.com" }

  s.source       = { :git => "https://github.com/AfrozZaheer/AZTableView.git" }

  s.resource_bundles = {
     'AZTableViewElements' => ['AZ-TableViewController/Classes/**/*.{xib}']
  }

 
  s.source_files = 'AZ-TableViewController/Classes/**/*.{swift}'

end
