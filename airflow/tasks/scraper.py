from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
import pandas as pd 


def get_page_src() -> str:
    chrome_options = Options()
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--headless')

    chrome_service = Service(ChromeDriverManager().install())

    driver = webdriver.Chrome(
        service = chrome_service,
        options = chrome_options
    )
    
    try:
        driver.set_window_size(1980, 1080)
        url = 'https://www.ultimatetennisstatistics.com/goatList'
        driver.get(url)

        btn_cookies_selector = "button.fc-button.fc-cta-consent.fc-primary-button"
        btn_n_players_selector = "button.btn.btn-default.dropdown-toggle"
        li_all_players_selector = "ul.dropdown-menu.pull-right > :last-child"

        # agree to cookies
        WebDriverWait(driver, 5).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, btn_cookies_selector))
        )

        btn_cookies = driver.find_element(By.CSS_SELECTOR, btn_cookies_selector)
        btn_cookies.click()

        # show all player stats
        WebDriverWait(driver, 5).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, btn_n_players_selector))
        )
        btn_n_players = driver.find_element(By.CSS_SELECTOR, btn_n_players_selector)
        btn_n_players.click()

        WebDriverWait(driver, 5).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, li_all_players_selector))
        )
        li_all_players = driver.find_element(By.CSS_SELECTOR, li_all_players_selector)
        li_all_players.click()

        # table extraction
        WebDriverWait(driver, 5).until(
            EC.presence_of_element_located((By.XPATH, '//tr[@data-row-id="20"]'))
        )

        return driver.page_source
    
    finally:
        driver.quit()

def extract_table(html: str) -> str:
    soup = BeautifulSoup(html, 'lxml')
    table = soup.find('table')
    return table

def extract_col_names(table: str) -> list:
    thead = table.find('thead')
    col_names_html = thead.find_all('span', {'class': 'text'})
    col_names = []

    for col_name_html in col_names_html:
        col_name = col_name_html.getText()
        col_names.append(col_name)

    return col_names

def extract_players(table: str) -> list:
    tbody = table.find('tbody')
    players_html = tbody.find_all('tr')
    players = []

    for player_html in players_html:
        player = []
        for cell_html in player_html:
            cell = cell_html.getText()
            player.append(cell)
        players.append(player)

    return players

def df(cols: list, data: list):
    df = pd.DataFrame(
        columns = cols,
        data = data 
    )

    return df


if __name__ == '__main__':
    page_src = get_page_src()
    table = extract_table(page_src)
    columns = extract_col_names(table)
    data = extract_players(table)
    df(columns, data)
