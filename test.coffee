assert = require 'assert'
test = require 'selenium-webdriver/testing'
webdriver = require 'selenium-webdriver'


test.describe 'Adslot website', ->

  # Browser (or driver) instance
  browser = null

  # Init browser before we begin
  test.before -> browser = new webdriver.Builder().usingServer().withCapabilities({browserName: 'chrome'}).build()

  # Close browser after all tests
  test.after -> browser.quit()


  test.it 'verify all form fields are available on "contact us" page', ->
    browser.get 'https://www.adslot.com/contact-us/'
    browser.isElementPresent(webdriver.By.xpath("//input[@id='input_2_1']"))
    browser.isElementPresent(webdriver.By.xpath("//input[@id='input_2_2']"))
    browser.isElementPresent(webdriver.By.xpath("//input[@id='input_2_3']"))   
    browser.isElementPresent(webdriver.By.xpath("//input[@id='input_2_4']"))
    browser.isElementPresent(webdriver.By.xpath("//input[@id='input_2_5']"))
    browser.isElementPresent(webdriver.By.xpath("//div[@id='input_2_6_chosen']"))
    browser.isElementPresent(webdriver.By.xpath("//input[@id='input_2_8']"))


  test.it 'title of first link from google search of "Adslot" should be "Adslot"', ->
    browser.get 'https://www.google.com.au'
    webelement = browser.findElement(webdriver.By.xpath("//input[@name='q']"))
    webelement.sendKeys("Adslot\n")
    browser.findElement(webdriver.By.xpath("//div[@class='g']//div//div//div[@class='rc']//h3[@class='LC20lb'][contains(text(),'Adslot')]")).click()
    browser.getTitle() == "Adslot"


  test.it 'verify that both "Careers" links on the homepage redirect to the same page', ->
    browser.get 'https://www.adslot.com/'
    browser.findElement(webdriver.By.xpath("//span[contains(text(),'Careers')]")).click()
    topURL = browser.getCurrentUrl()
    browser.navigate().to("https://www.adslot.com/")
    browser.findElement(webdriver.By.xpath("//a[contains(text(),'Careers')]")).click()
    bottomURL = browser.getCurrentUrl()
    topURL == bottomURL