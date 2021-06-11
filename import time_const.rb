require 'selenium-webdriver'
Selenium::WebDriver::Chrome::Servive#driver_path="C:/Program Files (x86)/Google/Chrome/Application/chromedriver.exe"

driver=Selenium::Webdriver.for :chrome

driver.manage.window.maximize()

def searching()
    
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    begin
        driver.get 'https://www.linkedin.com'

        #login
        username=wait.until{driver.find_element(css: "input[name='session_key']")}
        password=wait.until{driver.find_element(css: "input[name='session_password']")}
        username.clear
        password.clear
        username.send_keys('')        #enter username
        password.send_keys('')       #enter password

        wait.until{driver.find_element(css:"button[data-tracking-control-name='homepage-basic_signin-form_submit-button']")}.click

# arranging posts by recent activity:::rubified
        begin
            driver.find_element(xpath: '//*[@id="ember62"]/div/span[2]').click
            driver.find_element(xpath: '//*[@id="ember61"]/div').send_keys :tab , :arrow_down, :return
        rescue  

        end

#selecting the length of newsfeed to be read.
        driver.execute_script("window.scrollTo(0,5000);")           # change 5000 to whatever length of the feed you want to look at
        posts=driver.find_elements(xpath: '//*[@class="occludable-update ember-view"]')
        
        post_text=[]

        posts.each do |post| 
            post_text.push(post.text)
        end

        

        test_list=["Recently left my job","Looking for new opportunities",'likes this','celebrates this','commented on this']       #enter phrases of interest
        temp1=[]
        #rubified
        post_text.each do |p| 

            res=test_list.any? { |word| p.include?(word) }
            
            if res 
                temp1.push(p)
            end

            temp=temp1.clone

                splitted=[]
                temp.each do |elem| 
                    splitted.push(elem.split('\n'))
                end
        end

        identifier=['• 3rd+','• 2nd','• 1st','• 3rd']
        name1=[]
        name2=[]
        identifier.each do |id| 

            splitted.each do |sp| 
                begin
                    k= sp.index(id)
                    if k== true && id=='1st' 
                        name1.push(sp[k-1])
                    else
                        name2.push(sp[k-1])
                    end
                rescue => 
                    next

                end  

            end
        end

        #searching and messaging each connect

        searchbox1=driver.find_element(css: 'input[placeholder="Search"]')
        z="Write your message here"                                 #enter your required message here

        #rubified
        name1.each do |x| 
            searchbox1.clear
            searchbox1.send_keys x, :return
        end 


            wait.until{driver.find_element(css: 'div[class="linked-area flex-1 cursor-pointer"]')}.click()

            wait.until{driver.find_element(:link_text,'Message'))).click()
            message=driver.find_element(css: 'div[aria-label="Write a message…"]')
            message.send_keys(z)
            driver.action.key_down(:control).send_keys(:return).key_up(Keys.CONTROL).perform()
            message.send_keys(:escape)

        
            #this section of code writes all users who aren't connected but the program matched the phrases in their posts
        f = open("unconnected.txt", "a")
        name2.each do |x| 
            f.write(x)
        end
        f.close()

    #close the run iteration
        driver.quit

    end 
end
    
#rubified
while true
    searching()
    sleep
end        #enter time to loop the program after automatically
