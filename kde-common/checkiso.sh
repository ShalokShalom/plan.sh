#!/bin/bash

# === This file is part of IsoWriter - <http://github.com/kaosx/isowriter> ===
# 
#    Copyright 2016, Anke Boersma demm@kaosx.us>
# 
#    IsoWriter is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
# 
#    IsoWriter is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#    GNU General Public License for more details.
# 
#    You should have received a copy of the GNU General Public License
#    along with IsoWriter. If not, see <http://www.gnu.org/licenses/>.
# 

kdialog --passivepopup "Verifying the integrity of the USB in comparison to the downloaded ISO, this can take a few minutes...... " 15

CheckedFile=${1}
UsbDevice=$(pkexec /sbin/blkid | grep iso9660 | head -c 8)

if [ ! ${UsbDevice} ]; then

    kdialog --msgbox "No Flash USB detected."
    
else

    md5=$(md5sum ${CheckedFile} | head -c 32)
    bites=$(wc -c ${CheckedFile} | awk '{print $1;}')
    usb=$(pkexec /usr/bin/head -c ${bites} ${UsbDevice} | md5sum | head -c 32)
    
    if [ ${md5} == ${usb} ]; then
    
        kdialog --msgbox "The downloaded ISO file and USB write match.<br><br>
        md5sum for both is:<br><b>${md5}</b><br><br>Make sure to verify against the md5sum of the source where you downloaded the ISO from."
        
    fi

    if [ ${md5} != ${usb} ]; then
    
        kdialog --error "ISO files do not match, do not use this USB for install media. <br><br> Or make sure only one USB flash device is connected and run Verify again."
        
    fi
    
fi


