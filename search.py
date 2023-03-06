def searching():
    

    driver=webdriver.Chrome("C:/Program Files (x86)/Google/Chrome/Application/chromedriver.exe")
    driver.get("https://www.linkedin.com")

    #login
    username=WebDriverWait(driver,10).until(EC.element_to_be_clickable((By.CSS_SELECTOR,"input[name='session_key'] ")))
    password=WebDriverWait(driver,10).until(EC.element_to_be_clickable((By.CSS_SELECTOR,"input[name='session_password'] ")))
    username.clear()
    password.clear()
    username.send_keys("")        #enter username
    password.send_keys("")       #enter password

    WebDriverWait(driver,10).until(EC.element_to_be_clickable((By.CSS_SELECTOR,"button[data-tracking-control-name='homepage-basic_signin-form_submit-button']"))).click()

# arranging posts by recent activity
    try:
        driver.find_element_by_xpath('//*[@id="ember62"]/div/span[2]').click()
        driver.find_element_by_xpath('//*[@id="ember61"]/div').send_keys(Keys.TAB,Keys.ARROW_DOWN,Keys.RETURN)
    except:
        pass
#selecting the length of newsfeed to be read.
    driver.execute_script("window.scrollTo(0,5000);")           # change 5000 to whatever length of the feed you want to look at
    posts=driver.find_elements_by_xpath('//*[@class="occludable-update ember-view"]')
    posts=[post.text for post in posts]

    test_list=["Recently left my job","Looking for new opportunities",'likes this','celebrates this','commented on this']       #enter phrases of interest
    temp1=[]
    for p in posts:
        res = any(ele in p for ele in test_list)
        if res:
            temp1.append(p)

    temp=temp1.copy()

    splitted=[]
    for elem in temp:
        splitted.append(elem.split('\n'))

    identifier=['• 3rd+','• 2nd','• 1st','• 3rd']
    name1=[]
    name2=[]
    for id in identifier:

        for sp in splitted:
            try:  
                k= sp.index(id)
                if k== True and id=='1st':
                    name1.append(sp[k-1])
                else:
                    name2.append(sp[k-1])
            except:
                continue

    #searching and messaging each connect

    searchbox1=driver.find_element_by_css_selector('input[placeholder="Search"]')
    z="Write your message here"                                 #enter your required message here
    for x in name1:
        searchbox1.clear()
        searchbox1.send_keys(x)
        searchbox1.send_keys(Keys.RETURN)
        searchbox1.send_keys(Keys.ENTER)


        WebDriverWait(driver,10).until(EC.element_to_be_clickable((By.CSS_SELECTOR,'div[class="linked-area flex-1 cursor-pointer"]'))).click()

        WebDriverWait(driver,10).until(EC.element_to_be_clickable((By.LINK_TEXT,'Message'))).click()
        message=driver.find_element_by_css_selector('div[aria-label="Write a message…"]')
        message.send_keys(z)
        ActionChains(driver).key_down(Keys.CONTROL).send_keys(Keys.RETURN).key_up(Keys.CONTROL).perform()
        message.send_keys(Keys.ESCAPE)

    #this section of code writes all users who aren't connected but the program matched the phrases in their posts
    f = open("unconnected.txt", "a")
    for x in name2:
        f.write(x)
    f.close()

#close the run iteration
    driver.close()
    driver.quit()
    return
