--                              -*- Mode: Ada -*-
--  Filename        : ether-response.adb
--  Description     : Body for the response objects.
--  Author          : Luke A. Guest
--  Created On      : Sun Jul  4 19:22:48 2010

with Ada.Characters.Latin_1;
with Ada.Strings.Unbounded;

package body Ether.Responses is
   package L1 renames Ada.Characters.Latin_1;
   package US renames Ada.Strings.Unbounded;
   
   use type US.Unbounded_String;
   use type AWS.Messages.Status_Code;

   CRLF : constant String := (L1.CR, L1.LF);

   procedure Send
     (Output    : in GNAT.Sockets.Stream_Access;
      Status    : in AWS.Messages.Status_Code;
      Mime_type : in String;
      Content   : in String;
      Char_Set  : in String := "UTF-8") is
      
      Actual_Char_Set : US.Unbounded_String := US.To_Unbounded_String("; charset=" & Char_Set);
   begin
      if Char_Set = "" then
	 Actual_Char_Set := US.Null_Unbounded_String;
      end if;

      if (Status in AWS.Messages.Informational or
            Status = AWS.Messages.S204 or
              Status = AWS.Messages.S304) and then
      -- response must not include a message-body, or else raise Response_Error
        Content /= "" then
         raise Response_Error with
           "[Ether] Response with status """ & AWS.Messages.Image (Status) & """ must not include a message-body.";
      end if;

      String'Write
        (Output,
         "Status: " & AWS.Messages.Image(Status) & CRLF &
         "Content-Type: " & Mime_Type & US.To_String(Actual_Char_Set) & CRLF &
         CRLF &
         Content);
   end Send;
end Ether.Responses;
