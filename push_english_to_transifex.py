# Copyright (c) 2021 Sam Twidale (https://samcodes.co.uk/)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

'''
Run this script to push the English strings extracted from the project source code to transifex.
It does the following automatically:

- pushes the English (en) translation .ts file using the tx tool (you need this installed)
'''

try:
    import txclib.utils
except ImportError:
    print(
    'The \'transifex-client\' library needs to be installed. '
    'Please execute \'pip install transifex-client\''
    )
    sys.exit(1)

def get_tx_root():
    import txclib.utils
    tx_root = txclib.utils.find_dot_tx()
    if tx_root is None:
        raise "'.tx/config' not found. You need create a transifex config first."
    return tx_root

def push_translation():
    tx_root = get_tx_root()
    txclib.utils.exec_command('push', ['-s'], tx_root)

push_translation()