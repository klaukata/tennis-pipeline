import unittest
import scraper
from unittest.mock import MagicMock, patch

class TestScraper(unittest.TestCase):
    @patch('scraper.Options')
    @patch('scraper.Service')
    @patch('scraper.webdriver.Chrome')
    def test_driver_init(self, mock_driver, mock_service, mock_options):
        """
        Tests driver initialization
        """
        options_val = mock_options.return_value
        service_val = mock_service.return_value

        scraper.init_driver()

        mock_driver.assert_called_once_with(
            service = service_val,
            options = options_val
        )

    # TODO - test 4 widow size
    # TODO - test 4 get page source == html
    # TODO - test 4 correctly indentified html emements to click
    # TODO - output of get_page_src == html
    # TODO - output for extract_table == table html


if __name__ == "__main__":
    unittest.main() # allow tests to run using a form: python test_scraper.py
