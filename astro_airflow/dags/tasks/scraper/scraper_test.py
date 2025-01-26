import scraper as s
from selenium import webdriver
import requests
from unittest.mock import MagicMock

def test_init_driver():
    driver = None
    try:
        driver = s.init_driver()
        assert driver is not None
        assert isinstance(driver, webdriver.Chrome)
    finally:
        if driver:
            driver.quit()

def test_website_response():
    response = requests.get('https://www.ultimatetennisstatistics.com/goatList')
    assert response.status_code == 200

def test_fetch_website():
    driver = s.init_driver()
    website = s.fetch_website(driver)
    assert "goatList" in website.current_url
    driver.quit()

def test_get_page_src():
    driver = MagicMock()
    html = "<html>Mocked Page Source</html>"
    driver.page_source = html
    src = s.get_page_src(driver)
    assert src == html