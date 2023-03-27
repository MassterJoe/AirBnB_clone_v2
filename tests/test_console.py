#!/usr/bin/python3
"""unittest for console"""
import unittest
import console

class test_console(unittest.TestCase):
    """this will test the console"""
    @classmethod
    def setUp(cls):
        """setup for the test"""
        cls.consol = HBNBCommand()
       
if __name__ == '__main__':
    unittest.main()
        

