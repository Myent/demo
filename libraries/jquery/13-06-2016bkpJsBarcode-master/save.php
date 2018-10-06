<?php
//include('SimpleImage.php');
$data = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAfQAAACSCAYAAACzDDh5AAAY0UlEQVR4nO2dMU7b6xbE06ZNnzYtPXV6FpAFsIEsIYvIMrIQhCyEJQtZSFYkCho62u8VTx/PycN/H5+ZOV8+a0a6xRWXzPnNPcOxwTgfmmVZlmVZ0+vD6AEsy7Isy8Llg25ZlmVZZyAfdMuyLMs6A/mgW5ZlWdYZyAfdsizLss5APuiWZVmWdQbyQbcsy7KsM5APumVZlmWdgXzQLcuyLOsMFD7oH25u2oebm/DH+7///c+pH8/++az5ov9elUd03n+Fn/3/n82vmifqP9v+o/mreFl5sObJ+rH6ovJH/Vh8o/tXzRuVDzroX50Hu9Bq/qoCZ/lV80T9Z9t/NH8VLysP1jxZP1ZfVP6oH4tvdP+qeaPyQQf9q/NgF1rNX1XgLL9qnqj/bPuP5q/iZeXBmifrx+qLyh/1Y/GN7l81b1Q+6KB/dR7sQqv5q...CvUKneKe6QTs2nq7/t7aFnov1X1ZbeZe+9BzX9xXKHHlwcexEe45i3lj/op+zPIfVXv2d+jGFZLPmgW8PUX9i1/+/9Wc4pX+CXfvb9t369vLz9+fvv5d7fIezU93Lvz9yjb5py6lu/ZvP58fT0B0uf89iruPtfWnO13f7xHvAX6/Xiwbrabt9eVd//m/4e+f3Pe0/Xu93idwv6X2gTUfagn7o/+xn8enl5e6DjY26Nlg+6NUz9QO6/ecn+X0IS1Zf7+5MeALz3t61F/7asH09PJ/3NZ/13yY/9894Dgmw+/Xft++f1Q37Kg45+wPfzOfb5+8dtP5+lBy+RbA4d6cvN5ujnRn4ufsr+9Gfi+3z+mbn1r8gH3bIsy7LOQD7olmVZlnUG8kG3LMuyrDOQD7plWZZlnYF80C3LsizrDOSDblmWZVlnIB90y7IsyzoD+aBblmVZ1hnIB92yLMuyzkA+6JZlWZZ1BvoPovAbPKs8Oy0AAAAASUVORK5CYII="; // Your data 'data:image/png;base64,AAAFBfj42Pj4';
list($type, $data) = explode(';', $data);
    list(, $data)      = explode(',', $data);
    $data = base64_decode($data);
	//echo getimagesize($data)
	  file_put_contents('image.png', $data);
	  ?>