--                              -*- Mode: Ada -*-
--  Filename        : ether-response.ads
--  Description     : Interface for the response objects.
--  Author          : Luke A. Guest
--  Created On      : Sun Jul  4 19:22:48 2010

--  with Ada.Strings.Unbounded;
with GNAT.Sockets;
with AWS.Messages;
with Unicode.CES.Utf8;

package Ether.Responses is
   procedure Send
     (Output    : in GNAT.Sockets.Stream_Access;
      Status    : in AWS.Messages.Status_Code;
      Mime_Type : in String;
      Content   : in Unicode.CES.Utf8.Utf8_String;
      Char_Set  : in String := "UTF-8");

   Response_Error : exception;
end Ether.Responses;
