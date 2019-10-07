#!/usr/bin/python3
# author: Eduardo Marossi <eduardom44@gmail.com>

import logging
import argparse
import sys

def bindigits(n, bits):
    s = bin(n & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)

class Line_Assemble:
    def __init__(self):
        self.r_instructions = ['add', 'xor', 'sub', 'and']
        self.i_instructions = ['addi', 'xori', 'subi','lea', 'wea', 'andi']
        self.j_instructions = ['jmp', 'jg', 'jn', 'je']
        self.labels = {}
        self.address = 0
    
    def set_line(self, line):
        self.line = line.strip().replace('  ', ' ')
        if self.line.find('#') != -1:
            self.line = self.line[:self.line.find('#')]

        logging.debug('set line: {}'.format(self.line))

    def get_parts(self):
        instruct = ''
        if self.line.strip() == '':
            return ('', [])

        if ' ' in self.line:
            instruct = self.line[:self.line.find(' ')].replace(' ', '').lower()
            args = self.line[self.line.find(' '):].replace(' ', '')
        elif ':' in self.line: 
            instruct = self.line
            args = self.line[:self.line.find(':')]


        logging.debug('parts: {} {}'.format(instruct, args))
        return (instruct, args.split(','))

    def get_instruction_type(self):
        instruct = self.get_parts()[0]
        tp = None
        if ':' in instruct:
            tp = 'l'
        elif instruct in self.r_instructions:
            tp = 'r'
        elif instruct in self.i_instructions: 
            tp = 'i'
        elif instruct in self.j_instructions:
            tp = 'j'

        logging.debug('type: {}'.format(tp))
        return tp

    def first_pass(self):
        instruct, args = self.get_parts()
        if self.get_instruction_type() == 'l':
            self.labels[args[0]] = self.address
            logging.debug('set label {} to address {}'.format(args[0], self.address))
        elif self.get_instruction_type() != None:
            self.address += 1

    def get_instruction(self):
        instruct, args = self.get_parts()
        output = ""
        logging.debug(args)

        if self.get_instruction_type() == 'r':
            output = self.get_r_instruction(instruct) + self.get_register(args[2]) + self.get_register(args[1]) + self.get_register(args[0])
        elif self.get_instruction_type() == 'i' and len(args) == 2:

            if instruct == "lea":
                output = self.get_i_instruction(instruct) + self.get_register(args[1]) +  self.get_register(args[0]) + self.get_immediate(args[0], 8)
            else:
                output = self.get_i_instruction(instruct) + self.get_register(args[0]) +  self.get_register(args[1]) + self.get_immediate(args[1], 8)
        elif self.get_instruction_type() == 'i' and len(args) == 3:
            output = self.get_i_instruction(instruct) + self.get_register(args[2]) + self.get_register(args[1]) + self.get_immediate(args[0], 8)
        elif self.get_instruction_type() == 'j' and len(args) == 1:
            output = self.get_j_instruction(instruct) + "0"*8 + self.get_j_address(args[0])
        elif self.get_instruction_type() == 'j' and len(args) == 2:
            output = self.get_j_instruction(instruct) + self.get_register(args[0]) + self.get_j_address(args[1])

        if self.get_instruction_type() != None and self.get_instruction_type() != 'l':
            self.address += 1

        logging.debug('instruction: {}'.format(output))
        return output
        
    def get_r_instruction(self, instruct):
        table = {'add':'0', 'xor':'1', 'sub':'2', 'and':'c'}
        r = bindigits(int(table[instruct], 16), 4)
        logging.debug('r funct: {}'.format(r))
        return r

    def get_i_instruction(self, instruct):
        table = {'addi':'3', 'xori':'4', 'subi':'5', 'lea':'6', 'wea':'7', 'andi':'d'}
        r = bindigits(int(table[instruct], 16), 4)
        logging.debug('i instruct: {}'.format(r))
        return r
 
    def get_j_instruction(self, instruct):
        table = {'jmp':'8', 'jg':'9', 'jn':'a', 'je':'b'}
        r = bindigits(int(table[instruct], 16), 4)
        logging.debug('j instruct: {}'.format(r))
        return r

    def get_register(self, register):
        register = register.strip().replace(' ', '')
        if '(' in register:
            register = register[register.find('(')+1:register.find(')')]
        instruct = ''
        if '$' in register:
            register = register[register.find('$')+1:]

        if '%' in register:
            register = register[register.find('%')+1:]

        table = {'zero': '0', 't0':'1','t1':'2','t2':'3','t3':'4','t4':'5','t5':'6','t6':'7',
                't7':'8','t8':'9','t9':'a','t10':'b','t11':'c','t12':'d','t13':'e',
                't14':'f','t15':'10', 'rl0': '11','rl1': '12','rl2': '13','rl3': '14','rl4': '15','rl5': '16',
                'cr0': '17','cr1': '18','cr2': '19','cr3': '1a','cr4': '1b','cr5': '1c', 'am':'1d', 'mod':'1e'
                }


        if(register in table):
            r =  bindigits(int(table[register], 16), 8)
        else:
            r = bindigits(int(register, 16), 8)

        logging.debug('register: {}'.format(r))
        return r

    def get_immediate(self, immediate, size):

        if '$' in immediate and '(' in immediate:
            immediate = immediate[immediate.find('$')+1:immediate.find('(')]
        if '(' in immediate:
            immediate = immediate[:immediate.find('(')]
        elif '$' in immediate:
            immediate = immediate[immediate.find('$')+1:]
        
        r = bindigits(int(immediate), size)
        logging.debug('immediate: {}'.format(r))
        return r

    def get_j_address(self, label):
        a = self.labels[label]
        r = bindigits(int(a), 16)
        logging.debug('j address: {}'.format(r))
        return r


    def reset_address(self):
        self.address = 0


class MIPS_String_Format:
    def __init__(self):
        pass

    def begin(self):
        pass
    
    def end(self):
        pass

    def set_stream(self, stream):
        self.stream = stream

    def write(self, content):
        self.stream.write(content + "\n")


class MIPS_MIF_Format:
    def __init__(self, addr=14, data_width=28, increment_by=1):
        self.addr = addr
        self.data_width = data_width
        self.current_addr = 0
        self.increment_by = increment_by

    def set_stream(self, stream):
        self.stream = stream
    
    def begin(self):
        self.stream.write('DEPTH = {};\n'.format(2**self.addr))
        self.stream.write('WIDTH = {};\n\n'.format(self.data_width))
        self.stream.write('ADDRESS_RADIX = DEC;\n')
        self.stream.write('DATA_RADIX = BIN;\n\n')
        self.stream.write('CONTENT\n')
        self.stream.write('BEGIN\n')

    def write(self, content):
        self.stream.write('{}:   {};\n'.format(self.current_addr, content))
        self.current_addr += self.increment_by

    def end(self):
        if self.current_addr < 2**self.addr-1:
            self.stream.write('[{}..{}]:   {};\n'.format(self.current_addr, 2**self.addr-1, ''.zfill(self.data_width)))
        self.stream.write('END;\n')

class MIPS_Assemble:
    def __init__(self, out_format=MIPS_String_Format()):
        self.read_stream = None
        self.out_format = out_format

    def set_load_file(self, file_stream):
        self.read_stream = file_stream
        self.line_asm = Line_Assemble()

    def assemble(self):
        logging.debug('assemble')
        self.out_format.begin()
        self.read_stream.seek(0, 0)
        self.line_asm.reset_address()
        for i, l in enumerate(self.read_stream):
            self.line_asm.set_line(l)
            outp = self.line_asm.get_instruction()
            if outp != '':
                self.out_format.write(outp)
        self.out_format.end()

    def set_save_file(self, file_stream):
        self.out_format.set_stream(file_stream)

    def first_pass(self):
        # populate labels
        logging.debug('first pass')
        for i, l in enumerate(self.read_stream):
            self.line_asm.set_line(l)
            self.line_asm.first_pass()
        self.read_stream.seek(0, 0)
        self.line_asm.reset_address()


if __name__ == '__main__':
    argparse = argparse.ArgumentParser()
    argparse.add_argument('in_file', type=str)
    argparse.add_argument('-d', '--debug', default=False, action='store_true')
    argparse.add_argument('-m', '--mif-format', default=False, action='store_true')
    argparse.add_argument('-o', '--output', default="./output.mif")
    argparse.add_argument('-a', '--addr', type=int, default=16)
    argparse.add_argument('-w', '--width', type=int, default=28)
    argparse.add_argument('-i', '--increment-by', type=int, default=1)

    args = argparse.parse_args()
    if args.debug:
        logging.basicConfig(level=logging.DEBUG)

    out_format = MIPS_String_Format()
    if args.mif_format:
        out_format = MIPS_MIF_Format(addr=args.addr, data_width=args.width, increment_by=args.increment_by)

    mips = MIPS_Assemble(out_format)
    mips.set_load_file(open(args.in_file, 'r'))
    mips.set_save_file(open(args.output, 'w'))
    mips.first_pass()

    mips.assemble()
    