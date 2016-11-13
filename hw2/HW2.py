import argparse
# use an Argument Parser object to handle script arguments
parser = argparse.ArgumentParser()
parser.add_argument("-temperature", type=str, help="enter the filename of water temperature file without .csv")
parser.add_argument("-energy", type=str, help="enter the filename of energy file without .csv")
parser.add_argument("--test", action="store_true", help="tests the module and quits")
args = parser.parse_args()
# test argument problems early:
if args.test and (args.temperature or args.energy) :
    print("ignoring n, k or log arguments")
if not (args.test or (args.temperature and args.energy)):
    raise Exception("needs 2 filename arguments: waterTemperature and energy")

def RepresentsInt(s):
    try:
        int(s)
        return True
    except ValueError:
        return False
def main():
    filename1=args.temperature+".csv"
    filename2=args.energy+".csv"
    with open(filename1,"r") as fh:
        with open(filename2,"r") as en:
            with open("output.csv",'w') as csv:
                linelist=fh.readlines()
                k=0
                temperature={}
                t_date={}
                energy={}
                e_date={}
                line1=en.readlines()
                for line in line1:
                    line=line.strip()
                    if not line:
                        continue
                    string=line.split(",")
                    month=string[0][5:7]
                    date=string[0][8:10]
                    if RepresentsInt(date) and RepresentsInt(month):
                        e_date[k]=[int(month),int(date)]
                        energy[k]=float(string[1])/1000
                        k += 1
                for line in linelist:
                    line=line.strip()
                    if not line:
                        csv.write(line)
                        csv.write("\n")
                        continue
                    string=line.split(",")
                    if len(string) > 3:
                        line=line+","+"Energy Produced (Wh)"
                        csv.write(line)
                        csv.write("\n")
                        continue
                    if len(string) < 3:
                        csv.write(line)
                        continue
                    month=int(string[1][0:2])
                    date=int(string[1][3:5])
                    for i in range(len(e_date)):
                        if (month==e_date[i][0] and date==e_date[i][1]-1) or (month==e_date[i][0]-1 and date==e_date[i][1]+30):
                            line=line+","+str(energy[i])
                            csv.write(line)
                            csv.write("\n")
if __name__=="__main__":
    main()
