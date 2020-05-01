#! /bin/bash
ag -l REPLACEMEServiceNameCamelEMECALPER | xargs sed -i '' 's/REPLACEMEServiceNameCamelEMECALPER/ServiceName/g'
