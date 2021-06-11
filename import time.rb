require 'selenium-webdriver'
Selenium::WebDriver::Chrome::Service#driver_path="C:/Program Files (x86)/Google/Chrome/Application/chromedriver.exe"

driver=Selenium::WebDriver.for :chrome

driver.manage.window.maximize()

def searching()
    
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    begin
        driver.get 'https://www.linkedin.com'

        #login

end
    
#while true:
searching()
#    sleep()        #enter time to loop the program after automatically
