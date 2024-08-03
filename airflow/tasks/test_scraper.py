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

        scraper.get_page_src()

        mock_driver.assert_called_once_with(
            service = service_val,
            options = options_val
        )

    




if __name__ == "__main__":
    unittest.main() # allow tests to run using a form: python test_scraper.py
