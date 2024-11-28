import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/constants/utils/colors.dart';
import 'package:instagram_clone/constants/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a Photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Center(
            child: IconButton(
              onPressed: () => _selectImage(context),
              icon: const Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("Post to"),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAlAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAFBgAEBwMCAf/EADgQAAIBAwMBBgUCBgICAwEAAAECAwAEEQUSITEGEyJBUWEHFHGBkTKhI0KxwdHwFeEzUjXi8ST/xAAZAQADAQEBAAAAAAAAAAAAAAACAwQBAAX/xAAnEQACAgICAgICAgMBAAAAAAABAgARAxIhMQRBEyJRYTJxFKGxM//aAAwDAQACEQMRAD8AILYanpWreCDdBgggdN2B+n14z6dKE69crfXTpIjmRWGRg+IU86r2ogiDRJA8s0bh8AcYxg5+xNCbfQhOnzPhLKSWDedSOoFayxGJJ2i5pmtizu0WVZBHbNujDrhiuMMM/QnA867Wuo2MXaqZrGJLpZACXcBlwcE9epFFtWisLnRZX7gW92oO04HBHvSP2ftZTqMJddib/F5Y/wBNGKCwD9mqaDf6AktwsyyLbd6Dth7vIZh5YU4AIHQdKW9evA193BtxCsZCBITlVwc5z7nNO9noct1fQ3Mk7mKKP+GufM5B+nFLnxH0mHSI454AR3uQyr0J61nx3yRCGTX6gwBaXpDskpyoO1GPPQnz+5p7smYWMT6knfTA95bllzzjoPLNZVbvIArxqW6ZHJzTRe3cl9awrDJJIyx5Kcjb74/NCw1hKdu4ZthJG7zt3fexjAWXnJPnivPcXETb9R8SI+dg88jJA+hodYfw5oUnzujAcpg5K9T/AExTBDqUN9vcx906Bn7vGQwxUeQMo4liFSeYV0FoohMxk3RsBs88eZBo6ssJAEXiLHBpYtXt0AFvIm0jIAzkj/NHNLnBu0VUO4r4voKd4uU7aGTeVj43Ev3VhlhJHhBtw31pN7NCKfWLxrnxnnGfr/1TjrV6bXTZplH6UyKT+wcDzz3MhIIPmatVFUkiRF2Iow/YzJbyyJIxEbP4PYVX1eSBWkIBcFc5Aziuupw7YZom4YcqRQ6KU2uhyT3K72AO7IrSDNFdxSjkQ6hGsfHOaZezBLXEjIpZGyCvpSXHMQ7yR/8AkbK/QGtS7M2a2mjQ7kAYrlsjknzzQFLa4w5KSh7i3d2kqTuI4gUzlcnyqUSeS9S4n32wkLPnJfGPCOKlAfHSOHkPU46fHC10w1ARmXuu6bHAIq1pdzbsstqzDfCSsucc48/uMH70BuNYhiZ4ZUb5gn9cY5FC7CR73WBFN/DRzksDwBjqPuDQrlBX6wGxkNZMb7y0tL9DCrBbaLxsVI+wrOLt/mNakFtITulAUL54rRNG0t7QFAzTWspZsYO9Rnw/UbQKRO1Vgmka+89nISrqrpzkDnnHtxRP/EXMxkbGpoSXtzpVsrSqjALlxnnGPKlXXru61q1vpLu22COM9yHHKg+f++tW9F7SJq8kdrexoJGGfMAD71f7SpFBp0peEsryBInA/mBVQPyDRk8XArmjEDSbLYwR1HLeNgegHvRcHbsa2CxmNgVlC8+n0IND4ZxBcS2tyEbB3Da3OM5wa93EjtbQMW3FlIQehz7VCWbY3PQCqVFSyLuSbUJLucKqLEI1wMBgSc/nmiGjwRySTLKSX7oqAOcZ4JzQuK3j+UVrgsq7gBxjdjrzTLoENuJGkhGxiuTHnK4JGCvnigysdLE1AA9SvCIrORb3bJ3eSrZOPcEevSmTRpYrfVQk0ihHTcmW5ySKD3ds1zN8sn8KAyd42ecOAfCB6HOftVy0hAvkfUCCmNqlP0j0zQ43IcMYWRbxlZf+IV7JaaN/DIBdgPfH0rh2Nh+Q0iO4mRgJvFwvqeKGdpLqO6mkS7OD/wCIYOec44pstbqGDR4GVSyqi5AGSAPPH2r0lyhmInmPhKKD+Z9nQTO5IyMcGlDWNTc6Hewsu0rvVR6gGm2a8txD30LrIjDJKHIFI3bF7a6FqI5e7V3IbB6imMR3FpsTVRd7PDv9Zs45P0mQFh9OR/atgLNIFhRgqoPGfQ+VZRpll3PaO2isp92RnJ58jmtIluBFpzzIuTIxAx1OPD/auRgwsQsilTqZ5a9gikdJ9xcEZIPsKlVbazS4j72dWDE8eeR61K6zB4iJYTXSajb3MlmJsod5B5b39KK67NbTxLeqj25iZQWI25Rjhh+OftROGyVZ4ZYZNiuWVkj4BJ5z09vKvktutvcrciHMcabRIPGSx4PXn2/NSJYHUseruG7K5gGmw3qXqtEVGNzDnPSsy7eXs0mrAjuy0vknkc8g48/OmldLSwlS6gmUBGG+BgD3kZHHXzHT7UsduhaJd2eoaerKm7LIQFQ+uB5c/Y05uRFLwZS0h5oLhZgBG6AjJG4Nn60xP2lTVdPt7IKS4LTzFm5wuWwPuRQaSzuIHjEkbDvVDow5BB86+yRXdhJBfJIU77csg8wPL6euaUrGjY4jWUEiu5RngJ1GS7jOAPEVbrxRS0uo8wHZwp3DHXJz+1B7u+uJbx441YkIdxYc5xwc1Y059/cQsQokwMkdBjH9s0tlJEarAGG1MV6JYpRyC8m2Pj9/sa+fPN4Xtx3aomyLB5VfP71wlge1uQBKN+3qn6Sp/rVuaKNClyxMXeOrd0GyUU+dSMSOJVQu5Z0u/muBI902TbL3iyn+Vs9Pv/arum6rLe3EsQt4liMeZQCcZH8wHkeaotaQ2qzQySMsUhRC5JLbhk849Rn8UUf5Kw02UWQdZZlCk/vmjFERZ/qA9aljhEabULTP3Tbeu7dwfxTtZGxsrOCRLhwZk46nPlyKQNV0+2lvbGaCQmWS5UEOOp8z9K0S7tFu9OWBcJOo3IT0Lef5qrFYxWncmy02UBupxnCpbzSWqoZZeoiGNx9cHzxWd6ozNexRwxvNJvJMYGTjzp70x5obWZp0B2vjYfIjrQnSriKbU9RlEapOAMkDyP8A+VvylU2MEYrcqDF/R5xp1/cXMkEkdwg/hpJx1BGKcm+av7mKC28URXa53dFGM/k/0pe7WBZLAOOJt4Ab+ozTR2OsTHa29937DMeDEegrfHfcXO8hNDUOLZPGoVHwAOmKlfJr894RGhxUqu1kWrRN1KOa2aCKxVt0sobr+gA8nH3/AHoro+saTcakdNg3sbdcBSMKSDjA9fr0681w1W0Jvri5MkoWW32hU/UCmTgemcnn2HpR3s9Y6bZ2wWztkgzjcQclj7k8mlqtHiMLgjmc9W0ZZAt4Y1eSMeKPqpXz4Pn0IPqPrWX/ABL0q8tJ4LprnfZzthEH8hx0rV9Zvbi3uYO5AaNSe8UDlhism7cS3N7uPe//AMsUrBEJ5GCePwRXM6A/uaqORfqXfh811eNHHesZII12QA87M8f79KKX1yL3tMLaG3g7u0Zlh3J1I65/H2r18N5bG5trKD9E0C5OP5jhgSftXaa5h7OaxdXUtmlzc3DMzJvwIEJyB7k9T6UrIeAfUZjqzXJivqJmlvJpLjCOp8QxtC4qp8s0cbkMjbCOc8g56Vf1m7h1m7mmnRLKJky20k9Oa8xtZx6W0EUi5Em7LHxZ6Y985/pUpZRfNy0IxrifWle4ZBnBZgoyeFyf6UyLo15eWRa17vvGldH3HgDw8egxj9qWTbyxNtkQqc456fmm3TNft7DTFhVJ7iSNz80yqcDJJBz5nrR4CjWDF5w6kFYA1aK+t1hjuph3aDK7cEOBkdfTriiFrcx2+jFrxHzgon3oprkdjqdpBeW0iSiM8qhHKea+xFDg7S6D8sIULuCELHAyB4f99qDIBdw0Y1XuCdJd5JoVjt1leKTdkt4lHr+KezIcIwby5z1pC7Iw38d5LFMinb+onO4HPIPtTzJDNFKgVcRn9Waxd+QOpzacE9zrfSp8vL3eMsDnHrSR2fnkttYvI3UvGy7j4c5+/wBz+aLa7eXGmZlkQmPzA6UB7IX5u7+/kcKd2CA38o5xT9xW56iNDeo7lKa9kur67hAbuppMNGwzzkcj/qtFsbW7W3VId6IQMlqT4dHv4dWjuCFMU04y4/k5BH0/7p+u9YEN01ukWQmAST1NcubEq7k0Jz48jMEAsyzBbSpGAz5NSvMV+biNZIgMHggnoalNGTGebiTjyA9TtPFaSln8PeBSV+o6VyZLXT7JlkmCArtXJ8x6e9BGfvbJrt5JEjVQ7eW0cE0MsO11hqd4lpNaXILy/wAHIyGb3548q05aPUwYf3O17qeoW6rPHGGtsgvvzuI9aUe2xXUb1JIpNgKLIF28Hgj+1NDWc+kXVpca1dh7a+zHMmTi2c5IA9h0zQTtfpNxp1pazyXCvth2yr1JOeMH6UBJNxnA6lPQZJtL0+PUbdVEiHaoPnniinaC7k1B4J5QBcugjkhHU+hx9z+1AOzjS3awwA7gs2do5zgE0ck0rVWn/wCQSNhdNMNijnuweB+MVK1n6ypaFNBlxbtp1w8N9EQ+zwr589M1TRV8W0Da67QgGACelFtQl3RRLdO73g3QyJJg8q2QwPX1496A2t0J5JjEOYmIHPUe1C6aixCVweDDAudSa2EUyLvVmKs48sAAD2yKv6PJcd1cjU5Y4k47skhQOuMj35/BqlezJJbqygiSLYzIPvg/t/Su+iwtrV3DFI7Rssfiz5+I5+p5FcqlhdTmYK1XLEUMz99FAqpAX5YAEsfrQ7tBqN1Y2dntIWQS5Chcb1APBx9f3pq1xI9HMXy4JiZeqjIBHr9RSLe3sepa7L85FtWKImBC2ATkYJ+1FjRlJDdTsjhlBHZjIk8k8Hz0WUmaMOuTjw45HuQaYNL1i5ubOFpViKY5LHBP09aA2TQQBTjMZO9ec49qtS3MN3bpb28LGMNuDYxg0pWKi0huoY6tBfxB1ApYSxo5Zd4IHmoPUfmqHZ+zbSVSacjZcIu4AZPrXXtVHNc2Drb25doyRNnqFz1A86+6xM1vp9rd24KtAoVTzyWXn8Aj81QrfLiKt7k7KMWUMvqML6hDNFHFbXMYdwSAD4hx6eVWri3MqhI2BuSmVBPLAUmaH2VvIUXUZbtQ0oDbFBJAPnu9enGPvT7bXEAh+b7rbNBF3TsD+r14+371GPFQ5NQ1iU/5D6bVzKOnXLw2+xztYMcg1Ku2enfMRGeQjdI27mvtWjxiOpN/kj3BVxfvqej3Vvp4dna3I3Icc4of8P0dNQN00aYVCni67yR0/FHNG0eWzR4Y5MiPPjUdfevLwf8AHW1xPChGHZmIHOc8/wCazZhRI6mUDYEMaloaalb3PzuP4oAAA/SB6e9JnbGOGLQ44XWaQxSLEpfqyqBgmnfQ9Wj1MjupVljxhiP70vfESH5TRL6SZ43jILxMBgq+MACqAFYbLEEsratFz4bPafOOsuRIjkqSOg+taddzwRKj94FRQSSeh4P+DWNdi/loYri9a4IljTKqD1pq1OW6XRZZJoHWMkKqhsLh8jdj7/vQFgpMPQkDmC+0sZ1DUbqbTJY5IWi7/hsEn/1A65JBpb7K2rRwvcTLmJvAoB5znrTh2P0VrtZ7zvE2JuQpjLMccfTmlKx1B9JvryzuomMCykKwXhXzjGenNLG/xcRlr8g2h+S3uJYglvEQ0ZzJJ79F/oa9/D+Y3moXCTyHfEuYmBwQWPPT6CuljdXHy5kDEd4fEP5WXyNAOzt6dN7TmQYWKSVkIByACeK3xyGsH1O8i1qvce+0fex6PK1y+4qcsfUVn1zYpcahazwyh47h1CjPT6VoHbaYXGiSohAyvUeVZP2bdotRhkEhPdAsueQKPEtWwMDK10pEfb+5hsybMKWaPG9+mD5gexp2t7KGO3i7iMKrKG5HPPNJV3F83bW+oTRs08sobr4WUeXtwBinfS7ruraJJvGDGCkgHl6H3FKwIgYqfcZmZyob8Rc7Q3cNjqkUc6qI5UZWz/OR5Vx7Ym0OlWwcNHCzquFIGFyKHfE68t5dT0tNuds4ZgfTIrj8QdUhl022t4cZPJNM+BNwQYr52KkEdRm05vmNLRHlSRy20MgDKADxgfirFwkguGtWZVSRlb6jz/pWY9i9XlstWSF5SLSQHcpPGfb3rRNOuWu7uW5hjZ13eEnp05xSUwtiyUeow5VyY7EbIe7jiVAMADAqVQWKeQbi2CfKpVuxkuogm1vLy0uYUVu8E/6mbouKH6t/zUM2oXdtIvy6Ns7gDOVIBLY8yCcUxzRQlJGk8CrwMefvVRVWeeH/AJBCsjRgOy/pZgKkUEJqTKjRbZREVtUlVzLbMbYvt3iIkAsPP/qn3V0XU+wYkuNskslnuJ6gnbVHVuylhdB5YJ+5lYFhjoT9K+X9+kPZM2zHu2SERDPPIGK3E2jUZmVRkWxE74b6aJ5rizuQA0bozfTr+9aLLNYaml3p0+5Ng7tg3hyDwMf296ynsLqFxHfXE0Y72YKOvGQKerm8az7Py6zfBTclv4A2n9Z6Kfbimcbf9gV9f1GTszpJ0nSu5lIM0jFnI8vL+grHu2t1KbuSNgU/js+3b5eX+a2Xs9qp1jSort02MxKsPIkeY9qzX4rxxwzoCADL046Y60zVRrUUrH7XLHZTUE1e8ijUeFI/EPLPH+KXu2dm2n64/cjZGxDJ6A1Z+Gkp7y6VF/icYbHTij3aGzWPuJdRmR++BV9y8EjJGPfBakbHHmNDiUgfJiFmUr7Vnl7Oyi4XbIqY5+lJXZCBbzWreBzmMeIj6Yr3rV5dCDuRte3ViqyIdwK+XI/vRX4dwI+s79hPdxmnhSqE/mTkhnA/E1CSGGS0+WEZ7tcHj2opadzhUCgYAO3H71xjZVOcda7rHk95GcGkY01Nx+R7Gszn4h91J2v0mIrgM3I+9VPiTBDAlnsADHqB6V87cSSXHbvTolwWUrj85/tQz4gTyPqcEchPgiGfzVgHIkd0DB/ZvSG1fVIoiSEHLEeQrddMsYrO1SCJAFC44rMPhXHia4nPIJCj7Vq8DjyovcHoTsIRjzqV0U8VK6hO2MC3YEkvniNe8K+vkB/X8VRuLyK9iWRBgFvMdK+RXomMssRypY4J8wOB/vvVO3V47plCgxscgeleRk8i/qs9RMNctCAKd0lwBgAA7fT1od2qjtm0S5llAChSc+9W7wNFHIUUscAhRSz2jkkn0KS1Iw7HZtJ6en7YrlX7jYzmJKmon9g7gLrpYHZHglifIVq0axXqXWk3njtZsYPqGx09xWW9l7Z7D5pdpMjlVUEc7vT+larpV/ZqsVpgxzW4jQhh55FVK22Yj0P9yYpriH5MkV4NO1m20O1QLaquCcHIJBPX8fmlD4m6Q6RLKZHkXvMqWbIXjkUztEw7cq2AUaASH8Fc/mvHxEtzc9mroBSXRNy49uadjuz/AHFvQqvxM8+H17Faao6HnvAOelaF2ha1ubX5KRCZn58RxsHIBz/asm014rOyhvotjOZdsuT0B/tT/cXLXEvzO4sJIwqnP6cc1N5rsF2WU+Iqk6tEe7hTT9SCIwIKbkMgBBIPQ08/DqGy766u7aLuo8ZfIwFI6/ahlzp9gqtdagFcxqdmRgL5596Y+xmmxxaOAv6Zd2Ov6W54PUf9Vnj5zlWh2JmfCMR/RjUklvdIWt3VgPbBqxAmEJ9qBWEU1m7tAO+hQFSoyGHtzV3SdWivoZ1xtmQfozk49abhzg/XIKaLy4SPshsTOZj878VHJ5FsmP2/+1Lvbq4EvaOcL0QKv9/70y9lcXHxA1uZhnZwD+P8Uldr5e87R6gVPAlI/arPck9R8+Had1p4Pk5yPzWk2pGwUhdiohHo9scfy08WjYWuE4wipGOtfa4BxipWzIspG0Y2quOMY8qkEEpk3E8UWuIFKjHWqltbSLcM27cnktQN4/2uXDNazzcsVwDnBXGfzWd9tYzamSeWXwhlP6utapcwCaCTjaSAPpWYfECNrKyhEo7zdICCa4+OQ4PqYMwKG+4J7HX89z2gTdK8kajw/wC+taD2iuDbWzz2sad6AGc45x5fvWfdhYhP2gWWKNkVh4lI4FatcxMiAPAZUMg3ADOB0z9qoZeCBFBq5MB9lNTur66We5i3GKNoe86Hkg0ya0pk0y4UjOVPFVNHURazdxfLBYFUHdjgn2opcIstvMsZ8L5A9q7ECFozMpBPEwLTtHW4kvYpXdI4W2gKcA/Wumn61NA5tJZwIWyvi558qJdskm7OapNHCFb5uMOCT0wSKV9Ggt765kiuWdWYZQr6+eawqfsW6nBgNQvcZdX1ZbfTDatmWRpAjBm6KQSD9MA1p3Z+4DabbtGPDtGKwmeC6mn2FXl25CnH6hW1aDqUWn9ldJlMRcNtSXceUHr+1Djx48S8Q3d8rRljcNkMoz15obc6d3bm/sz3c65LpnAkH+aOXcMW6N42G1hkH1FVNUIjsX2ddvQU18auOYpXK9TNuwG5u0Wuzcfq8z7mkDW37zV75/WZ/vzTt8PA3/K6z1BZ+fyaXr3s9Kbuc78kyMf3orowdSRxNS7LWuNEtfLwDy9qYFVlPFU+z6BNFtVPUIB+1GQi4BJrRMM4qTivteyq561K2ZUq3LEIMYrxbMe9BqVKGF6nVnLK2fNuaW+19jb3cMPfpuCtkVKlY01e5V7M2kEN+ndxgcelGu2GpXOmJbtaMFLvtORnipUpY/jGN/KNFlGk9hFJIo3MgyRVO+RYY2EYwBzUqU71E+5lnxGsYbm5tpJQSwjYA596SrGxijMkiF1cdCDUqUMOuYz9lrdBbyFiWOCfEc801dlo1njmSXLIFwFPTnNSpUr85BK1/wDMw9olzLdWkLTuWI8OfYUVvYkaAgjyqVKrHQkbdmI/ZWzht9T1AxLgsefyaD3ng1BgP/avtSlv3GJ1NA0r/wCIj+g/pVmGRmCgmpUpoizPbdalSpWwZ//Z',
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Write a caption',
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQA7wMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAEBQIDBgABB//EADgQAAIBAwMCBQIDBwQDAQEAAAECAwAEEQUSITFBBhMiUWEycRSBkSNCobHB0fAzUmLxFSThggf/xAAaAQACAwEBAAAAAAAAAAAAAAABBQADBAIG/8QAJxEAAgIBBAICAgIDAAAAAAAAAAECAxEEEiExIkEFURMyFDMjQmH/2gAMAwEAAhEDEQA/APmVlKxdwDhQeo7VO+T0EkY4796XaRKVvArciToPntTu5ti47nnk+/8A8rFYtkxtS/yV5QqSJiABwanZOy/iPJzs3844/PPaj9QSO0tw5IDNwB7mhvDFut1ePE/IxvCk4yelXUtyTZk1kVHEAu1AVS7jG4gAYxx70yslZjKSCF27WYnABz/PihNaK2c+Om2PPT3zUtMf8RAkgC7nycbNzf4PerXyjAo4YdPa2ipgHcfhs0h1DTbizkjLxjEx4OOT/wAcVpbO0BfzZFLYYbVfHX34oie1W4ubNJT0lLqD3IB4/lVe/Zll0VvaiL9P8OtDJFMzRvswZVxwPgfbimGtW6SQkW6ydM/sXU/fjrWktbNEURuQV+n7k8n+lDajoVv5DOFYMuQzxnG09qUq+Vk8t9D6NUKIYSMFFKts3lSeu2Y5cEHKfOKLuIkUARmMxschkxgjPvS+6t54NUVJQwbIG7swpr/4yEEh3cxg58vPGfenVde6ORDqLlXPgoitA90zEkwwnHPc0JqVvHMysrLvAJAz1Gf5U/tLVLuH9mNkYOAB8UNrNokM9vkMo2FfTzjH/ZrqVuzg5p0zte5sQWsSRh7iONpFXho8epGPv8fNHadFLck8Ln4/dqF3v80y2uYpE5yD1o/wZmTUJopid4wwBouXhuK5wSt2sZx6OqQElPWR+YH3pbmXTtSt57IrFIrgbjzjPByPtW2ktlK4zx2H+6kurWDyoVI3YHCt2+xrHJuS5L6HGL5N6D5sYMTKwI+sHIxVRgSJGZ8YHqLMcdOpNfI7nxDr2jSw2tpdJbxJlliWJcHJJyePn4r2TX9Z1YEXd23lsoVo4xtUj5FL18TOTypcDJ/JQgugrx1qr3l9EbCX0WjEpIAPrzyQe46Yo3R/E1hqMMa306Qzx7QwkO3c2OxpK6ebJHaxbd7DPJA4qy90VTaskKFiqln9IBGPg1vu09MYxqfr2UaXUWylK1ezW3FouwSW7rleH2ng/f55pRcaWl1OZ2fyWAAbDnaSPisbD/5HS7tnikdG43jdw/HQ+/WjdO8QGG5ePUGcQO5O/G5gPbiua9HKptp5NE/kIWpRksM03/iPMG1JBJ2+gVKPwlvG6Qpx3C5pnp+uaI8QEd9ahVXOC4B/jQN1460+OUx2iS3PYeXwufknt9qKVmcJBlOpLLZnPE+jw6P5M0UwEzN6UA6gc5+KaaHNbX9j+MUhfK4mQnBU/wD3tSvUvxOqNLeXPLt0A6Kv+0VnlFxas5t5GQuPVsPb/utirls57E87IWWNpcGi1HUI7KMs2BLIxIXuay8kst1I0s3U9h0FWR2ss0mWDPI3vyT+dPbXwzO0QaYMpPTiilGtckcnPhGdUNE6SRkB0IINau1vbW9tGmWRROiZaPuPesyUIIyKigaCUSJnoR7cEYrm6lW8/Rdp9TKltfZZc3MmoXHmsMIvCL7D+9Ux3L292HgYpLH9Ldc1OFSGwOnHFVTRksWAwd1W7VFKKKW5Tbkw/Wr9tUlimcbG8tQ6/wDIe1M/Dsh/CCGQ4RmwWJ6CkkSCRQ2Oe9TkWYqEDEIOiijsysI4ctrwzeT6rpOn2zO9wjsvSKI5Y8cCstJ4iupNYt9QZAsUJIWL2U9fucUthtec4o82qmMfNBULDTOHqNrTR9IS9jurSC5tmBiMgJwc8kU0snlMc548wHkHmvj8M99pqSpZSlEc5K9QCO9PtL8ez21wFvLLdE+BIyNkj3IGKWWaCUHmPQ6r+RrthiXY11QjyrgyxwqzcJkdTnnHcHGaFlH7LI9qO8QyW189jdWrLJHKGZnU/Vxxx2PNBsQFP2plp44gJNXL/Jgr8K3am6uLCbOSfMX5FNddiTyIiY/Sr8jPOCKxeoia3ukurZyksZypFHv4n/G2jCeFhcjGcD0t9vauLaW5ZRr0upiq+fRTESbl42yQDxnriq5JZ7C7S7tTiSM5+49j8Vfp6PITLJy7d6uu4dyHitEYJQ2sw2277d6Nfo3iG01a3zDIolAG+M9VP9vmmOxCm5wNuMnJ6V8ikSewulntWKSL0Ye3t9q1U3iGa60SC2iQLPOD5pH7i98fesctO92EalbHbuFOr41TWZpUGI1/Zqw/eA7/AMTR1pZhVGKJsNOMUSZUdOwplFb7FyRWxJRSSMMpuUm2KtPsI38RxpcEgNGSm0dx9qY6oGXiKOMS7v2RUkg5x1z8ZqOp2jzlJraYRzxHKv8AcYIP5Gll3qS2wcPcefdsu0vtwkQ9his1tSc9z6Nunuk4bI9lOqSWlko88yOTnLKmaQyRWt8f/XmG49Ebg1pTrFnJbLHOytxjG0HJpReaF5yNdRg20X1Avxz8CrFYF6drnPIBHozHJbA296eWGhwfh45/N3BxkY6UFH5/4OSOWZnQZwWGCac6XEbWzihckqEGCK4vnhcFmlr3N55K5ysQ8iJSTg/woKzFvIJI3TbKp79wfam6lUuGdgPXGyg/NBanB5bLIgBZEwe2etURucZcmqzSxlB47LvDlnHLeTsgDtGB6SOgrRsJE6LgVhtO1CaxvZXt3OSuOemPf70VcaoCoZ5rhpCeVQV1YnOWTNXXtjyLrry5XaGJ0dmJA29qXMowMD9aKnvGN0kjIwdgFYshBaoy+UbhQGVsHdsHerKW4rBbqYqclJDbSfDU90qSvJszyu0Z5+TQ3iDTvwspY3SSEH6FXAH5/lT5dbd9PMYt0TaNq+U+Kzd9DcsnmT7grf8AHt8VVum5ZZdKqtV4QLp673aMggDkUxFupHShtOQC4WOOQkMMAEU4WJs8ittTyhRqouMwIQ7egq1F+KJkiK9apz7VaZDxokYH0iqZLBJB9PToaJWrx0xUJz6K7C3/AAyBVztznHai2bjFQXOMVILQ4Jy+waa3EwxigU07EucU6UVwTnOKOQYa6I2sQRAMdKueMEVJOlTJwK5IgGe0R/qHWrrOwRGDLVwbPFXICBknFQ65DYI9qjB49qKGxU9eKXRy445NTmdnj4FAIs17UTChht3PmSelVXqD8UksdCvLtg0v7IE5znn9KLub66srrcunxTgdC2d39a8udev7pNkFk8PGDzxVE1KTGNEq4R7DUtNN0YgiNbi6IyXk5x/ShZEvtXmKxKZNvIQcYpaLbUN5kdUJP+4k068POdK1GK5uZWIz+04z6ftVM4TjFtdovhdVnH2NbLwg0kAW7l9OMbY+taODw7potVgMB2gYBDkEU8gRXXdGQUYAjAyMVGWMov0twOwJ4pDPU3WPMmOIVVVrEEZmbwlEZN9tcv5fZHGSPzpFqFp5cZQjEjNtNbWa4KhlBVZPqx246/0NZTXLgRXs4yDtwVb33d/6VfTZJvkDSM9babazlpJJCMMVwowRz0JphbafbD6FUD3KZJ/WsvdXE9nqczWkjADGVHRuB2pnZeK4dwS5Qwv3I+mmcdzRgs2rsl4lt2nm3MDtPpUjt80li05h6iCCoBGV+aa6Xc3eo3XmzjJP+mnQDHIFMbi2cK0iIfLcnGev2+wrmVrr8TpVq17ymwiE8f7NQRnkDs1QnXP/AK5fIBxg0tP4mCdpLeQxEnnHf7jpULi4vjlmijZif9TGM4HtVyqk+Ylf8uEfGYVLafh5UkDBGRuMnrRa3ce446UieS5uXDXDAhegFXxgqAMVpqrcexfq74W8RGs9yHG0VQnNDZb3q6E1eL3wXqvNXIMVCOrN2KODjcXqKniqVerVbNTBNxYBVvkbhxUYuaNj+K5OkB+UV5AJ+Kg27uuKcKo6fnUXtw3RRn5oBTFUW0P6qtkmQjFWT2jAkrxQ5gkHX+FQ7RyEYJB70VGW+kLlT3odIyo9XSrlfbjbkc0CBFzAmFzjdig3j29KuaQyenp7GoPkfUME8ioFZA5fSCaUXlwV6dQeKcSo0reXGMsfbtTWPwzbtp/nGQiYjJaRD/KqLrYwRt0umla89EPBPjW1ijh0rU5BEVO2Gb93HZTjoa+hKwdQytuHuCK+M6tppG8AwTKP/wAtSW21bU9GuMaddXEOAV8stuUZ+On8KUT0sL3ug8McylOhJS5R94utPiu19abG/wB4IzXy7xva3dnL/wCvJHcbf2bSRtkrg5GV9/UftxTXw7rOuX9m1xrNziM8JEi43D3YAc/rTGe7NxbmFYIlC9CnH8KFNE6p5fKK7L4yi10fJFknTLsdzHOSa90qzF5JNvXLA5xWx1TRYrmQlR5crfvY4rIv5+l30ht2zIjFWyODTVSi14mFb0/PlH0TSrGKFd4yAfXGeu09x+uavmVJNMj4JLcsffOTtFSldYtOkkTLI4OAvVX6V4W/YxopV5FXkfuoP8/Ok0m28scxX0Z3WIguxmPCnDfc80EsZmAEaFvgDNGa6JLi9htYMEKC83H05PBP+fyrReHrVFt1iRAqLw793at8dV+ClZ7F1ujeoveOEvZnI9CvGTcIcDOMEjNc+i3qHHk55xwa+hxiEBpyMoBtT5+1V7AQ2VG88sAOnxVUfk5t9Bl8VWo9s+ZPC6NtdSp9jU4+lPdS0zy5/NuDsUnoo5pXqLQWyqFiUs5O3nkD3ppVepia3TuOStWA71LdmhVl3dsVYrVpyZHEKU0RGRQaNRUPNQiWAuIjNMLcZx7GlsYIamtqxwOOlcM6CwEUcEZ969HyapZwOoFSBHvmoA9ZNxxzj5qiZVTtRHm7eW6Cg7y5Vxx1qBIMm4ZAqCY3bSKHE7D6WIqxLjHUAn3qYO0wh9o+kUDcz7QcnpXs8/tSbU7opG2OTjjJodcnUVl4RZZTzXGpK0ReKKM8yKpP6VtY9UKwkRz3JGPqkgFYLTNQuHYCS4kHT0oua1umPJcSRwFrgIWALO44z9qVal5PR6SCUVnog9vLqjeW1vbyB8gS7SuPy/8AtBPokC2sc8YIdXZXbHPwf4fxraCSO2igWBQB5zqM8n94Up1f9nY32w7RC6yHH3BrGoyRudkWBRDbEiAtkLjhiP0xRscYRVzknrg8/wAaVW1/axx+ZJcRhsZ9TAY/zIpZqni+2hJS0zcSYwCv05+TW6EG1gS28zH12Ik9cpCAc5Jx3rGJbi/uZ71DGqFztWQfV80Heale6nlb2fbCxH7KPhR96awW58najqpbBBB4cf3riT2I1U17nliweMLiaHy7mBdzY3vGcbueuPfirpfFbeSsdlCyynjfJjAPuAOp+az+bV2PokUjtuAH8qKtViEyssXTnBPWtEq6lzgohK+XGQ3T3vIo3uA7MZmYSbjknb3/AFrUWGoCK0jtwSpYYJz0XvSeS6i6QRN6xt2Ip78nn3qgPdTSySLF5aYCtnlkHyO1ZLUrHyMaV+NJLk3un6xbzxq6tyDthU859jinMasYSFbYxHqLDcx/TvXzvSoTbev8ObhD0kQ+oU4k1fyBuEtyhHUMp46/FYJ0+Xiam048huvSWum2ry3crybugySSa+eSSvc3DTt1Y8AnoO1F+INTbUXAWRjGOpbqf1oGDtmnmiqcIZfZ5rXzi5tR6CEyBVqsc1WWwK9Vq3i5xDYmo2A0tjcAijIpBUOGNIiCMUwhYBeAeaSxy4otLnjGaGDnIe3XnpV8IUDrSk3PPWro7k45xihgGQ25IaJgOtJn3KcGmUTB25bFCanEUkDdsUUGWQYPXu7FQQFzhalIjJ1okRROxweaTXe+WUIgyetNJ34NKWuVtLhpHDHAwFXrXEui+r9gu0sZ48PLKyKOynBrUaKSXLRcIJeF9sCssmuWMjL55lTH/DNG2vivT7KIGBZZW43LtwcHvWGcJS9DWq7Ybuz2i3WSTnY7ynP58/xpVcaxo+64S9nhK3GWIdsgqvUffNYnUvFt9fWslpHCLdGG3IJLYz0rNNC7nJ3Ennnua5Wl9ss/mPpIYaxqVvqMzra2MFsolLIUGG2ex/nVMMRABRSfyqu3j9aBx8Uwkv5ogqlEdI+MAYyKtnGWNsQQcE99jOt7WST0qhB6g5praWWowx7IwGiPO3f0qix1nTWkxOrQAd2GR/CnyeINDiiw1+hP2J/pWCz8q42jKEqWs7j595MkJIZVJC54PWmejwXzzRXcRiWNDn9oeH+MVCa1uLi+McIzgFjxng/3ppY+Zbf+nMPLlThQAWyPitlkvHC7F9EG5ZeUh2kttfSeU0RilI/0zwJAO4P+4VdPD5boJG2MRmG5XkN/xb7UplQzL5ciMHHIY5BH2+aHd9XhVlS5E8YH0yLWP8OemMHe4rDWRtM8cDkzQlGz/q2zcH8qW30zOM/iHaJRli456UsutamjkKGzCHGCpb+lCveXNz6XYrHjhR0Fa6tNh5Yvv1mVg5z5kzMCxHbdRUaEAVC3j96KX0it+MCmT3MgV4rgMVcscj8JG7H2UVKe3khZRINpZc7cUN8c4yR1T27scFIJBoiOQjvVO2pKKsM7QYknzVyycdaDQVctE5aCA9TEmO9D12a6wVcjSByxUZ70wuIiYsYzSKGbYeRx/Kmn4lmiBDZ4qtou7Kyu0jCAGvZNpT1AVESFlO44NR3cbep96B1gXXEeQSOgNKrq335OKcTtkFaEZMjnP5USRbTET2fq4ArlsjnoaZP5kk3lW0aySdlJwTVLWOoyMxeN4x0WMenH2quU0jXXCc12QSwcLuEbEDuB0rrWeGJzZXcIeCVhhgPUCfntRFtNfwgW/wC0UE4GR/WvdXV55d1yo4UZKDbz/mKqc88M0RocXlMF1Wz/AAF2igEhhuUkdRQbnOTjOelX3Fzc3XlRXO1hCCA4HqYH3omzsHdv2iYYMOPgiovBZJ/ZJR9AS6PLcW/mRrzjP3pU0JU7WGCOo9q+lRW4S2CqvpA5rMarppa92wLl35ZfaopLuRJwy/Ed+E54pHuHkB2l1Hq7kD+5qeoW63XrYAESsFx+f9qRaFfrbXoSQYExG09s4rQTMDbkpyRJkD35zS+2DjZkbaexTqwU2sgBChwdvVZDyvxn2oyW4toFhWfyjJKxw27NL9QhziWBmVyN6kHn5H8qSXWoTXMbQ3BO9ScEH1gfepGDkw2WqES7xAbOd1e3mjaReCFHUUBGu3HNCwj/AKojcB3GKaVxUY4PP3T3ybGFojSSKkY3MegFPLPTwk8StHuO0scgHnIpl4M02JLGOeaJRJL1YjnB6fyp1JZxxGOTGMZBP+fak+s173OER78boIRSnZyxVEjOkHO1vrc9MA0H4jhWSOGbpg7fpxx/an8FohiZ22qznO0n6R2GKR+JdsVsigtu392JJ/Wsmjtb1ETd8hCL0s0IdvxiuC15vHP3r0MDXqjxDZLFeg4qJYVWzUCF4epBx70IHNSD80ck2hRbiiImOwYJpeJKJW54AxQJgNVuAGP61InCkUNFOGIzjip3E/HpoHSB5CNxNQPSqy+TXu7jmicsW6hE27zImZXU5VlOCDTTRPFcvmLbao656CYjA/P5oScdQaT3lup7VXZWpGrT3Otn06S4spIdzeUwx6WJFK7s2F5A0TL5bn6ZFGRn5r52JbqMCNLiZUHRVkIA/KpRpPKSWlkPBPLk5rK6n9jGOoh9DK+jFpJKm8MI+cryGPFae32SSRzJgrJGp49x3rGKAse3knk++D81K31O/wBOUxQsChOQjLnZn29qtknhFFc8N/8ATY3V60IPlFeCfW/0r9vc0i0+Vri7llDFwOC5PU0tddT1D1sThuKtt7XUbAP5MfoOPkVROO5YyaK7oxlnHAjDuowGNOrDxFNCnlXC+YpI5HXik5XINGW1ss8PbcvBq2UVLsphZKHKNLbavaXMe1XRcNja/pPNLdRsvKJnXkdcj2pe2n7Rkc/brRFumT5YlcAjDLuOK4VSXR3LU7v2Lvw6PAHAwSM0Z4es7e+/Gw3KljGEYYHOMnOKGhdVjMYOSvFTi1F9Gu4rpFEiMNkkfuOvB96knLa0itKPDNz4VkRLRrMy7mt/Rzx6T0P+f0pveP5oSLG4Md7gLuwRx/E4/Q1jI7yGeVb/AEm6QOB6g3seqMO33qxfGFnC0hu45GuOnlxDcBgcYJx/hpTdpJSnmKHFGphGK3M16uwBVAEJ6YAFYrxRe+ZqKW6YxEpZvV0Y+4pvp2q3PiCOXyIzZWo9G88yN74x0/jVdx4WsVgItnkjY9WLZyfnPf7VNNKrS25s7DrI26mlqroyoYkdakGI71Ze2ctlN5UpU/8AIdDVBODjOfmvRQnGcd0ejy1lcoS2yWGWhs14agDUs10Vo8NSUE1EsKsRxUCR5zUgTUGYE14GqBCYXIYCiJFdkLe1BQuPMGaaOA0AwfqGKBBW7bTXRyB50iLqpc4BY4Ge1eXieWeDmldy7YyDyOlR9Bgk3yaOz0qe5ujazMIJj9IccN+dKbi3KPLHJhJImKsrdfvWz08LqWmWc27IKjnjchHzS7xjpgCjUI+XwFnAHXtu/lWNXyTwxo9HW1lGTS3R5QmQCWGSR0FF3FtvUeSNqZGw1Zo0sT3RjmzuKDDr1Bz/ANVfb28kd7LCBt8oZB7EZ/tRsnnolFSink660+NtO5QK6cqqnkmjbPw9b2ltHK4MjEbiPbNA3U5gjklk3bQp/OtNazJPZxshXDKMc/FVybObVt4Fs0IhUGPG1ugqKj04yQKLbMOVKhkPbvQrEKfSSR/Kh2VxznJgY+mauspGjkbb365rq6tDJ6DhK/HPeuZQZAcer/d3NeV1FFfsgpKvIAehqu/YsYg3IzXV1T2droFQbJ0ZeCCDkU1uLCKO3S6DOzyKWIOMfyrq6uLHiSwW1pODybn/APnMEc2ib2GGW4kUFTjitTLEmcEA8457V1dXmNc3/IkP9H/VEzfiG1hkgbcvTPI+1YpRzjtXV1N/h5NxkmxZ85FKUXj0SPHSvMmurqdCArJOa9VjXV1EhxY12411dUCehj1pjHcOIF6cAdq9rqAGLbmRnOWNBT8qa8rqj6DHs7TtYvNMm2Wsg2O3KNyKcX+uX0tr63UhuCpXiurqytLI0rk9op05yb2T/kvP61tbZFkjWd+ZCoUn35rq6uJ9nUX4CPxiRHp5CgcyBc/HWvPDNxJ/4pRu+gkD7V1dR/1KbP2G0jllXP7w/SgZSVPBNdXVUGJ//9k=',
                              ),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ),
          );
  }
}
